allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    project.pluginManager.withPlugin("com.android.library") {
        configureAndroidProject(project)
    }
    project.pluginManager.withPlugin("com.android.application") {
        configureAndroidProject(project)
    }
}

fun configureAndroidProject(project: Project) {
    val android = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
    android?.apply {
        ndkVersion = "28.2.13676358"
        defaultConfig {
            externalNativeBuild {
                cmake {
                    arguments("-DANDROID_STL=c++_shared")
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
