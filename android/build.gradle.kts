// android/build.gradle.kts (nivel de proyecto)
import org.gradle.api.tasks.Delete

plugins {
    // Otros plugins ya configurados…
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// (Opcional) Unifica la carpeta de build para todos los submódulos
val rootBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(rootBuildDir)

subprojects {
    val subBuildDir = rootBuildDir.dir(project.name)
    project.layout.buildDirectory.value(subBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
