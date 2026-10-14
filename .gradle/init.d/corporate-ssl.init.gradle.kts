// 社内ネットワークのTLS中間証明書(Zscaler等)がJava標準の証明書ストアに
// 入っておらず、Gradleの依存解決でSSLエラーになるため、Jamf配布のCA証明書
// を取り込んだ専用トラストストアを使う。
// トラストストア自体は setup-corporate-truststore.sh で生成する(未生成なら何もしない)。
val truststore = file("${System.getProperty("user.home")}/.gradle/corporate-truststore.jks")

if (truststore.exists()) {
    System.setProperty("javax.net.ssl.trustStore", truststore.absolutePath)
    System.setProperty("javax.net.ssl.trustStorePassword", "changeit")
}
