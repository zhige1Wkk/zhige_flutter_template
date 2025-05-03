pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        // 优先使用华为云镜像
        maven {
            url = uri("https://mirrors.huaweicloud.com/repository/maven")
            isAllowInsecureProtocol = true
        }
        // 华为云的gradle插件镜像
        maven {
            url = uri("https://repo.huaweicloud.com/repository/maven")
            isAllowInsecureProtocol = true
        }
        // 备用镜像
        maven {
            url = uri("https://maven.aliyun.com/repository/central")
            isAllowInsecureProtocol = true
        }
        maven {
            url = uri("https://maven.aliyun.com/repository/public")
            isAllowInsecureProtocol = true
        }
        maven {
            url = uri("https://maven.aliyun.com/repository/gradle-plugin")
            isAllowInsecureProtocol = true
        }
        maven {
            url = uri("https://maven.aliyun.com/repository/google")
            isAllowInsecureProtocol = true
        }
        maven {
            url = uri("https://maven.aliyun.com/repository/jcenter")
            isAllowInsecureProtocol = true
        }
        maven {
            url = uri("https://repo.spring.io/plugins-release")
        }
        maven {
            url = uri("https://jitpack.io")
        }
        gradlePluginPortal()
        mavenCentral()
        google()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
}

include(":app")
