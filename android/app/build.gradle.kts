plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// 获取系统JDK版本的函数
fun getSystemJavaVersion(): JavaVersion {
    val javaHome = System.getenv("JAVA_HOME") ?: ""
    return when {
        javaHome.contains("1.8") || javaHome.contains("8") -> JavaVersion.VERSION_1_8
        javaHome.contains("11") -> JavaVersion.VERSION_11
        javaHome.contains("17") -> JavaVersion.VERSION_17
        javaHome.contains("21") -> JavaVersion.VERSION_21
        else -> JavaVersion.VERSION_17 // 默认使用Java 17
    }
}

android {
    namespace = "com.zhige.zhige_flutter_tempate"
    compileSdk = 33  // 降低为33以适应更多库
    
    // 指定使用已存在的正常 NDK 版本
    ndkVersion = "29.0.13113456"
    
    // 根据系统环境变量动态设置Java版本
    val systemJavaVersion = getSystemJavaVersion()
    println("检测到系统Java版本: $systemJavaVersion")
    
    compileOptions {
        sourceCompatibility = systemJavaVersion
        targetCompatibility = systemJavaVersion
    }

    kotlinOptions {
        jvmTarget = when(systemJavaVersion) {
            JavaVersion.VERSION_1_8 -> "1.8"
            JavaVersion.VERSION_11 -> "11"
            JavaVersion.VERSION_17 -> "17"
            JavaVersion.VERSION_21 -> "21"
            else -> "17"
        }
    }
    
    // 解决依赖库的资源问题
    packagingOptions {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
            // 忽略可能冲突的资源
            pickFirsts += "**/*.so"
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.zhige.zhige_flutter_tempate"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 33  // 显式设置targetSdk为33
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
