# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

#################################################################################

##开启混淆会将代码中的所有变量、函数、类的名称变为简短的英文字母代号（也可自定义），在缺乏相应的函数名和程序注释的情况下，即使被反编译，也将难以阅读，提升应用的安全性；
##混淆通过分析字节码，去掉冗余代码，再加上缩短了变量、函数、类的名称，可以进一步缩减应用大小，如果想混淆资源文件，
##可以使用微信的 AndResGuard。 https://github.com/shwenzhang/AndResGuard

##FAQ：今天在逛github时，突然发现一个比较好的配置第三方混淆的开源库 是Blankj大佬维护的
##项目地址 https://github.com/Blankj/FreeProGuard
## 依赖引用这个库以后，我们就不用担心混淆配置了，因为我们平时工作所使用的到的几乎所有第三方库的混淆配置都已经被写好了，我们只需要在build中进行引用就行了

## 第一步 :设置 minifyEnabled true；
## 第二步 :#添加依赖： #implementation "com.blankj:free-proguard:1.0.0"
## 第三步 :自己排查下有没有还需要保持不被混淆的jar，sdk，或者依赖，自己添加到 proguard-rules.pro
## 第四步:打包测试完成就ok了


## 以下是原来项目的经常使用的一些混淆配置
#################################################################################

-dontwarn okio.**
-dontwarn javax.annotation.**
#指定代码的压缩级别
-optimizationpasses 5
# 去除编译时警告
-ignorewarnings

#不压缩输入的类文件
-dontshrink

#包明不混合大小写
-dontusemixedcaseclassnames
#不去忽略非公共的库类
-dontskipnonpubliclibraryclasses

#不优化输入的类文件
-dontoptimize
 #预校验
-dontpreverify
 #混淆时是否记录日志
-verbose
 # 混淆时所采用的算法
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
#保护注解
-keepattributes *Annotation*,InnerClasses

# 避免混淆泛型
-keepattributes Signature

# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

#####################2.默认保留区################

# 保留support下的所有类及其内部类
-keep class android.support.** {*;}


# 保留继承的
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**
-keep class android.support.design.** { *; }
-keep class android.support.v4.widget.** { *; }
-keep interface android.support.design.** { *; }
-keep public class android.support.design.R$* { *; }

#保持哪些类不被混淆
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService


##保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}


#保持自定义控件类不被混淆
-keepclassmembers class * extends android.app.Activity{
    public void *(android.view.View);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
#保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

#保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
  public static final ** CREATOR;
}
#保持 Serializable 不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 对R文件下的所有类及其方法，都不能被混淆
-keep class **.R$* {
 *;
}

# 对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
-keepclassmembers class * {

void *(**On*Event);

void *(**On*Listener);

}

#避免混淆泛型 如果混淆报错建议关掉
#–keepattributes Signature

#####################3.webview################

-keepclassmembers class fqcn.of.javascript.interface.for.webview {
   public *;
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.webView, jav.lang.String);
}

-keepattributes *Annotation*
-keepattributes *JavascriptInterface*
#排除混淆webview
-keepclassmembers class * extends android.webkit.WebChromeClient{
       public void openFileChooser(...);
}




########################
# Retrolambda
-dontwarn java.lang.invoke.*
-keepattributes Exceptions
-keepattributes InnerClasses

########################

# Marshmallow removed Notification.setLatestEventInfo()
-dontwarn android.app.Notification
#####################
-dontwarn javax.annotation.**
-dontwarn javax.inject.**

#####################
# OkHttp3
#-dontwarn com.squareup.okhttp3.**
#-keep class com.squareup.okhttp3.** { *;}
#-dontwarn okio.**

# Okio
-dontwarn com.squareup.**
-dontwarn okio.**
-keep public class org.codehaus.* { *; }
-keep public class java.nio.* { *; }

#####################
# Retrofit 网络请求框架
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-dontwarn retrofit2.Platform$Java8
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}
-keepattributes Signature
# Retain declared checked exceptions for use by a Proxy instance.
-keepattributes Exceptions

#####################
# Gson
#-keepattributes Signature-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.examples.android.model.** { *; }
-keep class com.google.gson.** { *;}
-keep class com.yc.sqt.moudle.** {*;}

#####################
# EventBus
-keepattributes *Annotation*
-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }

#####################
# RxJava RxAndroid
-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
   long producerIndex;
   long consumerIndex;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}


#####################
#Glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
#Glide
#####################

# for DexGuard only
#-keepresourcexmlelements manifest/application/meta-data@value=GlideModule

#####################
# butterknife
# Retain generated class which implement Unbinder.
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}

#####################
#AndroidUtilCode
-keep class com.blankj.utilcode.** { *; }
-keepclassmembers class com.blankj.utilcode.** { *; }
-dontwarn com.blankj.utilcode.**
#####################
# MPAndroidChart 强大优雅的条形图框架
-keep class com.github.mikephil.charting.** { *; }

#####################
## styleabletoast 用户交互的toast
-keep class com.muddzdev.styleabletoastlibrary.**{*;}
#####################
## 优雅的android弹出框
-keep class com.afollestad.materialdialogs.**{*;}

## Requery
-dontwarn java.lang.FunctionalInterface
-dontwarn java.util.**
-dontwarn java.time.**
-dontwarn javax.annotation.**
-dontwarn javax.cache.**
-dontwarn javax.naming.**
-dontwarn javax.transaction.**
-dontwarn java.sql.**
-dontwarn android.support.**
-dontwarn io.requery.cache.**
-dontwarn io.requery.rx.**
-dontwarn io.requery.reactivex.**
-dontwarn io.requery.query.**
-dontwarn io.requery.android.sqlcipher.**
-dontwarn io.requery.android.sqlitex.**
-keepclassmembers enum io.requery.** {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}


-keep class com.example.sdk.**{*;}

-keep class es.dmoral.toasty.**{*;}

-keep class com.pili.pldroid.player.** { *; }
-keep class com.qiniu.qplayer.mediaEngine.MediaPlayer{*;}


#百度地图混淆
-keep class com.baidu.** {*;}
-keep class vi.com.** {*;}
-dontwarn com.baidu.**
#####################
# materialdatetimepicker 时间控件选择器
-keep class com.wdullaer.materialdatetimepicker.** {*;}
-dontwarn com.wdullaer.materialdatetimepicker.**

-keep class com.bigkoo.pickerview.** {*;}
-dontwarn com.bigkoo.pickerview.**

#####################
# 腾讯bugly
-dontwarn com.tencent.bugly.**
-keep public class com.tencent.bugly.**{*;}

-dontwarn com.journeyapps.barcodescanner.**
-keep public class com.journeyapps.barcodescanner.**{*;}

#####################
# arcgis 地图服务
-dontwarn com.esri.**
-keep class com.esri.** { *; }
-keep interface com.esri.** { *; }
-keep class org.codehaus.jackson.** { *; }
-dontwarn org.codehaus.jackson.map.ext.**
-dontwarn jcifs.http.**

#####################
##视频直播  金山云视频和自定义包名

-keep class com.ksyun.** {
  *;
}

-keep class com.ksy.statlibrary.** {
  *;
}

-dontwarn com.sugon.library.**
-keep class com.sugon.library.** {
  *;
}

-keep class org.xmlpull.v1.** { *;}
-dontwarn org.xmlpull.v1.**

#####################
##litepal 强大的android本地数据库
-keep class org.litepal.** {*;}
-keep class * extends org.litepal.crud.DataSupport {*;}
-keep class * extends org.litepal.crud.LitePalSupport {*;}

#####################

#libs第三方jar包
#-libraryjars ./lib/ksoap2-android-assembly-2.4-jar-with-dependencies.jar
#-libraryjars ./lib/ksoapWebService.jar
#-libraryjars ./lib/wmqtt.jar

#-libraryjars ./libs/achartengine-1.0.0.jar
#-libraryjars ./libs/com.szmap.projection.android-2.0.2.jar
#-libraryjars ./libs/ftp4j-1.7.2.jar
#-libraryjars ./libs/locSDK_2.6.jar

#############################
##如果要对libs中的所有jar包都进行防混淆可以直接使用以下
##-libraryjars libs
