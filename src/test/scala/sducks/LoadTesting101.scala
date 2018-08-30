package sducks 

import io.gatling.core.Predef._ 
import io.gatling.http.Predef._
import scala.concurrent.duration._


class LoadTesting101 extends Simulation {
  val targets = sys.env.get("TARGETS").getOrElse("http://localhost:5000")
  val target = targets
  val httpConf = http.baseURL(target) 
  val x = 30;
  val scn = scenario("LoadTesting101")
    .exec(http("static_1mb").get("/static/1mb.txt"))
    .exec(http("fib_rec").get(s"/fib_rec?x=$x"))
    .exec(http("fib_iter").get(s"/fib_iter?x=$x"))
    .exec(http("fib_gen").get(s"/fib_gen?x=$x"))
    .exec(http("fib_memo").get(s"/fib_memo?x=$x"))

  setUp(
    scn.inject(rampUsers(120) over (600 seconds))
  ).protocols(httpConf)
}
