/// <reference path="banner.ts" />

namespace com.keyman.osk {
  /**
   * This object is used to specify options by both `BannerManager.getOptions`
   * and `BannerManager.setOptions`.  Refer to the latter for specification of
   * each field.
   */
  export interface BannerOptions {
    persistentBanner?: boolean;
    enablePredictions?: boolean;
    imagePath?: string;
  }

  export type BannerType = "blank" | "image" | "suggestion";

  /**
   * The `BannerManager` module is designed to serve as a manager for the
   * different `Banner` types.
   * To facilitate this, it will provide a root element property that serves
   * as a container for any active `Banner`, helping KMW to avoid needless
   * DOM element shuffling.
   *
   * Goals for the `BannerManager`:
   *
   * * It will be exposed as `keyman.osk.banner` and will provide the following API:
   *   * `getOptions`, `setOptions` - refer to the `BannerOptions` class for details.
   *   * This provides a persistent point that the web page designers and our 
   *     model apps can utilize and can communicate with.
   *   * These API functions are designed for live use and will allow 
   *     _hot-swapping_ the `Banner` instance; they're not initialization-only.
   * * Disabling the `Banner` (even for suggestions) outright with 
   *   `enablePredictions == false` will auto-unload any loaded predictive model 
   *   from `ModelManager` and setting it to `true` will revert this.
   *   * This should help to avoid wasting computational resources.
   * * It will listen to ModelManager events and automatically swap Banner 
   *   instances as appropriate:
   *   * The option `persistentBanner == true` is designed to replicate current 
   *     iOS system keyboard behavior.
   *     * When true, an `ImageBanner` will be displayed.
   *     * If false, it will be replaced with a `BlankBanner` of zero height, 
   *       corresponding to our current default lack of banner.
   *   * It will not automatically set `persistentBanner == true`; 
   *     this must be set by the iOS app, and only under the following conditions:
   *     * `keyman.isEmbedded == true`
   *     * `device.OS == 'ios'`
   *     * Keyman is being used as the system keyboard within an app that 
   *       needs to reserve this space (i.e: Keyman for iOS),
   *       rather than as its standalone app.
   */
  export class BannerManager {
    private _options: BannerOptions = {};
    private bannerContainer: HTMLDivElement;
    private activeBanner: Banner;
    private alwaysShows: boolean;
    private imagePath?: string = "";

    public static readonly DEFAULT_OPTIONS: BannerOptions = {
      persistentBanner: false,
      enablePredictions: true,
      imagePath: ""
    }

    constructor() {
      // Step 1 - establish the container element.  Must come before this.setOptions.
      this.constructContainer();

      // Initialize with the default options - 
      // any 'manually set' options come post-construction.
      // This will also automatically set the default banner in place.
      this.setOptions(BannerManager.DEFAULT_OPTIONS);

      // Register a listener for model change events so that we can hot-swap the banner as needed.
      let keyman = com.keyman.singleton;
      keyman.modelManager['addEventListener']('modelchange', this.selectBanner.bind(this));
    }

    /**
     * Constructs the <div> element used to contain hot-swapped `Banner` instances.
     */
    private constructContainer(): HTMLDivElement {
      let keymanweb = com.keyman.singleton;
      let util = keymanweb.util;

      let d = util._CreateElement('div');
      d.id = "keymanweb_banner_container";
      d.className = "kmw-banner-container";
      return this.bannerContainer = d;
    }

    /**
     * Returns the `Banner`-containing div element used to facilitate hot-swapping.
     */
    public get element(): HTMLDivElement {
      return this.bannerContainer;
    }

    /**
     * This function corresponds to `keyman.osk.banner.getOptions`.
     * 
     * Gets the current control settings in use by `BannerManager`.
     */
    public getOptions(): BannerOptions {
      let retObj = {};

      for(let key in this._options) {
        retObj[key] = this._options[key];
      }

      return retObj;
    }

    /**
     * This function corresponds to `keyman.osk.banner.setOptions`.
     * 
     * Sets options used to tweak the automatic `Banner` 
     * control logic used by `BannerManager`.
     * @param optionSpec An object specifying one or more of the following options:
     * * `persistentBanner` (boolean) When `true`, ensures that a `Banner` 
     *   is always displayed, even when no predictive model exists 
     *   for the active language.
     *
     *   Default: `false`
     * * `imagePath` (URL string) Specifies the file path to use for an 
     *   `ImageBanner` when `persistentBanner` is `true` and no predictive model exists.
     * 
     *   Default: `''`.
     * * `enablePredictions` (boolean) Turns KMW predictions 
     *   on (when `true`) and off (when `false`).
     * 
     *   Default:  `true`.
     */
    public setOptions(optionSpec: BannerOptions) {
      let keyman = com.keyman.singleton;

      for(let key in optionSpec) {
        switch(key) {
          // Each defined option may require specialized handling.
          case 'persistentBanner':
            // Determines the banner type to activate.
            this.alwaysShows = optionSpec['persistentBanner'];
            break;
          case 'enablePredictions':
            // If we're not going to show suggestions, it's best to turn off predictions.
            keyman.modelManager.enabled = optionSpec['enablePredictions'];
            break;
          case 'imagePath':
            // Determines the image file to use for ImageBanners.
            this.imagePath = optionSpec['imagePath'];
            break;
          default:
            // Invalid option specified!
        }

        this._options[key] = optionSpec['key'];
      }

      this.selectBanner();
    }

    /**
     * Applies any stylesheets needed by specific `Banner` instances.
     */
    public appendStyles() {
      if(this.activeBanner) {
        this.activeBanner.appendStyleSheet();
      }
    }

    /**
     * Sets the active `Banner` to the specified type, regardless of 
     * existing management logic settings.
     * 
     * @param type `'blank' | 'image' | 'suggestion'` - A plain-text string 
     *        representing the type of `Banner` to set active.
     */
    public setBanner(type: BannerType) {
      switch(type) {
        case 'blank':
          this._setBanner(new BlankBanner());
          break;
        case 'image':
          this._setBanner(new ImageBanner(this.imagePath, ImageBanner.DEFAULT_HEIGHT));
          break;
        case 'suggestion':
          this._setBanner(new SuggestionBanner());
          let keyman = com.keyman.singleton;
          let banner = this.activeBanner as SuggestionBanner;
          keyman.modelManager['addEventListener']('invalidatesuggestions', banner.invalidateSuggestions);
          keyman.modelManager['addEventListener']('suggestionsready', banner.updateSuggestions);
          break;
        default:
          throw new Error("Invalid type specified for the banner!");
      }
    }

    /**
     * Handles `ModelManager`'s `'modelchange'` events, 
     * allowing logic to automatically hot-swap `Banner`s as needed.
     * @param state 
     */
    private selectBanner(state?: text.prediction.ModelChangeEnum) {
      let keyman = com.keyman.singleton;

      // Only display a SuggestionBanner when the current 
      // language has an active predictive model.
      // ModelManager will never have an active model 
      // when predictions are disabled.
      if(keyman.modelManager.activeModel) {
        this.setBanner('suggestion');
      } else if(this.alwaysShows) {
        this.setBanner('image');
      } else {
        this.setBanner('blank');
      }
    }

    /**
     * Internal method used by the public API `setBanner`.  `setBanner` 
     * translates the string parameter into a new instance consumed by this method.
     * @param banner The `Banner` instance to set as active.
     */
    private _setBanner(banner: Banner) {
      if(this.activeBanner) {
        if(banner == this.activeBanner) {
          return;
        } else {
          let prevBanner = this.activeBanner;
          this.bannerContainer.replaceChild(banner.getDiv(), prevBanner.getDiv());

          if(prevBanner instanceof SuggestionBanner) {
            let keyman = com.keyman.singleton;
            keyman.modelManager['removeEventListener']('invalidatesuggestions', prevBanner.invalidateSuggestions);
            keyman.modelManager['removeEventListener']('suggestionsready', prevBanner.updateSuggestions);
          }
        }
      }

      this.activeBanner = banner;
      this.bannerContainer.appendChild(banner.getDiv());
    }

    /**
     * Gets the height (in pixels) of the active `Banner` instance.
     */
    public get height(): number {
      if(this.activeBanner) {
        return this.activeBanner.height;
      } else {
        return 0;
      }
    }
  }
}