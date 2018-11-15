package sducks 

import io.gatling.core.Predef._ 
import io.gatling.http.Predef._
import scala.concurrent.duration._

//export JAVA_OPTS="-Dusers=4 -Dramp=30 -Dgatling.core.runDescription=DB -Dtarget=https://ubc51c33ea.execute-api.us-east-1.amazonaws.com/Prod/"
//sbt "gatling:testOnly sducks.LoadTestingDB"
class LoadTestingDB extends Simulation {
  val users = Integer.getInteger("users", 1)
  val ramp = java.lang.Long.getLong("ramp", 0L)
  val target = System.getProperty("target","http://localhost")
  val scenarioName = System.getProperty("gatling.core.runDescription","scenarioXX")
  val httpConf = http.baseURL(target) 
  val x = 10000;
  val scn = scenario(s"load_${scenarioName}")
    .exec(http(s"${scenarioName}_fib_rec").get(s"/fib_rec?x=25"))
    .exec(http(s"${scenarioName}_fib_iter").get(s"/fib_iter?x=$x"))
    .exec(http(s"${scenarioName}_fib_gen").get(s"/fib_gen?x=$x"))
    .exec(http(s"${scenarioName}_fib_memo").get(s"/fib_memo?x=$x"))
    .exec(http(s"${scenarioName}_put_rand_ddb").get(s"/put_rand_ddb"))
    .exec(http(s"${scenarioName}_put_rand_rdb").get(s"/put_rand_rdb"))

  setUp(
    scn.inject(rampUsersPerSec(1) to (1.0+users) during (ramp seconds))
  ).protocols(httpConf)

}
