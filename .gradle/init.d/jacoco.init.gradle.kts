// プロジェクト側のbuild.gradle(.kts)を変更せずに、javaプラグインを使う
// すべてのプロジェクトへJaCoCoを適用する。テスト実行後に自動でカバレッジ
// レポート(XML/HTML)を生成する。
allprojects {
    plugins.withId("java") {
        apply(plugin = "jacoco")

        tasks.named<Test>("test") {
            finalizedBy(tasks.named("jacocoTestReport"))
        }

        tasks.named<JacocoReport>("jacocoTestReport") {
            dependsOn(tasks.named("test"))
            reports {
                xml.required.set(true)
                html.required.set(true)
            }
        }
    }
}
