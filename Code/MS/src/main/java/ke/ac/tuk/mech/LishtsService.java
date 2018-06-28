package ke.ac.tuk.mech;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;

public class LishtsService extends AbstractVerticle {

    Logger logger = LoggerFactory.getLogger(LishtsService.class.getName());

    @Override
    public void start() {
        logger.info("My mY mechanical students are greate! ->");
        Router makanga = Router.router(vertx);
        makanga.get("/sports").handler(this::sports);
        
        this.vertx.createHttpServer()
            .requestHandler(makanga::accept)
            .listen(8080);
        logger.warn("Server started successfully! how greate is that!");
    }

    private void sports(RoutingContext rc){
        try {
            JsonObject name = null; /* new JsonObject()
            .put("fname", "Felix")
            .put("mname", "Otieno")
            .put("lname", "Okoth");*/
    
            rc.response().end(name.encode());       
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            rc.response().end("Ooops! So sad something went wronh! No worries, we are working it.");
        }
     
    }

}
