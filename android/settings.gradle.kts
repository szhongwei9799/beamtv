pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        // 优先从 local.properties 读取 (本地开发)
        val localPropsFile = file("local.properties")
        if (localPropsFile.exists()) {
            localPropsFile.inputStream().use { properties.load(it) }
            val sdkPath = properties.getProperty("flutter.sdk")
            if (sdkPath != null) return@run sdkPath
        }
        // 其次从环境变量 (CI/CD 如 GitHub Actions)
        val envSdkPath = System.getenv("FLUTTER_ROOT")
        if (envSdkPath != null) return@run envSdkPath

        error("flutter.sdk not set. Create local.properties or set FLUTTER_ROOT env var")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.0.21" apply false
}

include(":app")
