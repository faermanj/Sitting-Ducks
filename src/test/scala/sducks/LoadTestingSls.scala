package sducks 

import io.gatling.core.Predef._ 
import io.gatling.http.Predef._
import scala.concurrent.duration._

//export JAVA_OPTS="-Dusers=10 -Dramp=15 -Dtarget=http://localhost:3000"
class LoadTestingSls extends Simulation {
  val users = Integer.getInteger("users", 1)
  val ramp = java.lang.Long.getLong("ramp", 0L)
  val target = System.getProperty("target","http://localhost")
  val scenarioName = System.getProperty("gatling.core.runDescription","scenarioXX")
  val httpConf = http.baseURL(target) 
  val x = 10000;
  val scn = scenario(s"lt_${scenarioName}")
    .exec(http(s"${scenarioName}_fib_rec").get(s"/fib_rec?x=25"))
    .exec(http(s"${scenarioName}_fib_iter").get(s"/fib_iter?x=$x"))
    .exec(http(s"${scenarioName}_fib_gen").get(s"/fib_gen?x=$x"))
    .exec(http(s"${scenarioName}_fib_memo").get(s"/fib_memo?x=$x"))

  setUp(
    scn.inject(rampUsers(users) over (ramp seconds))
  ).protocols(httpConf)

}
