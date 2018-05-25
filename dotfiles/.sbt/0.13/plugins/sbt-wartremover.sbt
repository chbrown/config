// http://www.wartremover.org/
// > WartRemover is a flexible Scala code linting tool.
// Published at: https://search.maven.org/#search|gav|1|g:"org.wartremover"%20AND%20a:"sbt-wartremover"
// Runs at compile/test time, but by default, all checks are disabled.
// To enable, add one of the following to your `build.sbt` config:
//   wartremoverErrors ++= Warts.unsafe
//   wartremoverErrors ++= Warts.all
//   wartremoverWarnings ++= Warts.all
addSbtPlugin("org.wartremover" % "sbt-wartremover" % "2.2.1")
