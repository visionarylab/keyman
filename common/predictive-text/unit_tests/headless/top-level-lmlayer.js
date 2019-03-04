var assert = require('chai').assert;
var sinon = require('sinon');

let LMLayer = require('../../build');

// Test the top-level LMLayer interface.
// Note: these tests can only be run after BOTH stages of compilation are completed.
describe('LMLayer', function() {
  describe('[[constructor]]', function () {
    it('should accept a Worker to instantiate', function () {
      new LMLayer(createFakeWorker());
    });
  });

  describe('#initialize()', function () {
    it('should accept capabilities and model description', function () {
      let fakeWorker = createFakeWorker();

      let lmLayer = new LMLayer(fakeWorker);
      lmLayer.initialize("./unit_tests/in_browser/resources/models/simple-dummy.js");

      assert.isFunction(fakeWorker.onmessage, 'LMLayer failed to set a callback!');
    });

    it('should send the `initialize` message to the LMLayer', async function () {
      let fakeWorker = createFakeWorker(fakePostMessage);
      let lmLayer = new LMLayer(fakeWorker);
      let configuration = await lmLayer.initialize("./unit_tests/in_browser/resources/models/simple-dummy.js");

      assert.propertyVal(fakeWorker.postMessage, 'callCount', 1);
      // In the "Worker", assert the message looks right and
      // ASYNCHRONOUSLY reply with ready message.
      function fakePostMessage(data) {
        assert.propertyVal(data, 'message', 'initialize');
        assert.isString(data.model);
      
        callAsynchronously(() => fakeWorker.onmessage({
          data: {
            message: 'ready',
            configuration: {}
          }
        }));
      }
    });

    it('should resolve with the model configuration', async function () {
      let expectedConfiguration = {
        leftContextCodeUnits: 32,
        rightContextCodeUnits: 0,
      }

      let fakeWorker = createFakeWorker(function fakePostMessage(_data) {
        callAsynchronously(() => fakeWorker.onmessage({
          data: {
            message: 'ready',
            configuration: expectedConfiguration
          }
        }));
      });

      let lmLayer = new LMLayer(fakeWorker);
      let actualConfiguration = await lmLayer.initialize(
        {
          maxLeftContextCodeUnits: 32,
        },
        {
          kind: 'wordlist',
          words: ['foo', 'bar', 'baz', 'quux']
        }
      );

      // This SHOULD be called by initialize().
      assert.deepEqual(actualConfiguration, expectedConfiguration);
    })
  });

  // Since the Blob API is limited to browsers, look for those
  // tests for .asBlobURI() in the in_browser tests.
  describe('.unwrap', function () {
    it('should return the inner code of a function', function () {
      // Create a multi-line function body we can match in a RegExp.
      let text = LMLayer.unwrap(function hello() {
        var hello;
        var world;
      });
      // Unwrap should give us back ONLY the body. Whitespace isn't really important.
      assert.match(text, /^\s*var\s+hello;\s*var\s+world;\s*$/);
    });
  });

  /**
   * Returns an object implementing *enough* of the Worker
   * interface to fool the LMLayer into thinking it's
   * communicating with a bona fide Web Worker.
   * 
   * @returns {Worker} an object with sinon.fake() instances.
   */
  function createFakeWorker(postMessage) {
    return {
        postMessage: postMessage ? sinon.fake(postMessage) : sinon.fake(),
        onmessage: null
      };
  }

  /**
   * Call a function in the future, i.e., later in the event loop.  
   * The call does NOT block the current execution.
   * Use this to fake asynchronous callbacks. 
   * 
   * @param {Function} fn function to call
   */
  function callAsynchronously(fn) {
    if (typeof process !== 'undefined' && process.nextTick) {
      // Preferred way to do it in Node.JS
      process.nextTick(fn);
    } else {
      // In all other JavaScript environments (e.g., the browser)
      setTimeout(fn, 0)
    }
  }
});
