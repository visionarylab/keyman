package com.tavultesoft.kmea.util;

import android.os.Build;
import android.support.v4.widget.TextViewCompat;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.util.ReflectionHelpers;

@RunWith(RobolectricTestRunner.class)
public class FileUtilsTest {

  @Test
  public void test_hasFontExtension() {
    String filename = "test/abc.ttf";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.TTF";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.otf";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.OTF";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.woff";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    // Test SVG limited to SDK 17 and 18
    ReflectionHelpers.setStaticField(Build.VERSION.class, "SDK_INT", 15);
    filename = "test/abc.svg";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abc.SVG";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    ReflectionHelpers.setStaticField(Build.VERSION.class, "SDK_INT", Build.VERSION_CODES.JELLY_BEAN_MR1);
    filename = "test/abc.svg";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.SVG";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    ReflectionHelpers.setStaticField(Build.VERSION.class, "SDK_INT", Build.VERSION_CODES.JELLY_BEAN_MR2);
    filename = "test/abc.svg";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    filename = "test/abc.SVG";
    Assert.assertTrue(FileUtils.hasFontExtension(filename));

    ReflectionHelpers.setStaticField(Build.VERSION.class, "SDK_INT", 27);
    filename = "test/abc.svg";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abc.SVG";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abcttf";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abc.font";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abcsvg";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abc.svg#";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "test/abcwoff";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));

    filename = "";
    Assert.assertFalse(FileUtils.hasFontExtension(filename));
  }

  @Test
  public void test_hasSVGViewBox() {
    String filename = "test/abc.svg#xyz";
    Assert.assertTrue(FileUtils.hasSVGViewBox(filename));

    filename = "test/abc.SVG#xyz";
    Assert.assertTrue(FileUtils.hasSVGViewBox(filename));

    filename = "test/abc.svg#xyz";
    Assert.assertTrue(FileUtils.hasSVGViewBox(filename));

    filename = "test/abcsvg#xyz";
    Assert.assertFalse(FileUtils.hasSVGViewBox(filename));

    filename = "";
    Assert.assertFalse(FileUtils.hasSVGViewBox(filename));
  }

  @Test
  public void test_hasJavascriptExtension() {
    String filename = "test/abc.js";
    Assert.assertTrue(FileUtils.hasJavaScriptExtension(filename));

    filename = "test/abc.JS";
    Assert.assertTrue(FileUtils.hasJavaScriptExtension(filename));

    filename = "test/abc.sh";
    Assert.assertFalse(FileUtils.hasJavaScriptExtension(filename));

    filename = "test/abcjs";
    Assert.assertFalse(FileUtils.hasJavaScriptExtension(filename));

    filename = "";
    Assert.assertFalse(FileUtils.hasJavaScriptExtension(filename));
  }

  @Test
  public void test_hasKeyboardPackageExtension() {
    String filename = "test/abc.kmp";
    Assert.assertTrue(FileUtils.hasKeyboardPackageExtension(filename));

    filename = "test/abc.KMP";
    Assert.assertTrue(FileUtils.hasKeyboardPackageExtension(filename));

    filename = "test/abc.kmpo";
    Assert.assertFalse(FileUtils.hasKeyboardPackageExtension(filename));

    filename = "";
    Assert.assertFalse(FileUtils.hasKeyboardPackageExtension(filename));
  }

  @Test
  public void test_isWelcomeFile() {
    String filename = "test/welcome.htm";
    Assert.assertTrue(FileUtils.isWelcomeFile(filename));

    filename = "test/welcome.HTM";
    Assert.assertTrue(FileUtils.isWelcomeFile(filename));

    filename = "test/WELCOME.HTM";
    Assert.assertTrue(FileUtils.isWelcomeFile(filename));

    filename = "test/welcome.html";
    Assert.assertFalse(FileUtils.isWelcomeFile(filename));

    filename = "test/zap-welcome.htm";
    Assert.assertFalse(FileUtils.isWelcomeFile(filename));

    filename = "test/welcomehtm";
    Assert.assertFalse(FileUtils.isWelcomeFile(filename));

    filename = "";
    Assert.assertFalse(FileUtils.isWelcomeFile(filename));
  }

}
