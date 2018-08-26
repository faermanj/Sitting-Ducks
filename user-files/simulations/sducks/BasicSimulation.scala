package sducks 

import io.gatling.core.Predef._ 
import io.gatling.http.Predef._
import scala.concurrent.duration._

val static-text = exec(http("static-text") 
    .get("/static-text"))

class BetterSimulation extends Simulation {
    val httpConf = http.baseURL("http://localhost:5000")

    val scn = scenario("Scenario Name").exec(static-text) 
    setUp(
        scn.inject(
            //atOnceUsers(1)
            constantUsersPerSec(1) during (30 seconds)
    ).protocols(httpConf))
}
