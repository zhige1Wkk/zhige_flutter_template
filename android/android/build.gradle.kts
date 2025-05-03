allprojects {
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
            url = uri("https://jitpack.io")
        }
        gradlePluginPortal()
        mavenCentral()
        google()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
