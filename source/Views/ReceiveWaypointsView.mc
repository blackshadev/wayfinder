import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;
import Toybox.Communications;

class ReceiveWaypointsView extends WatchUi.View {
    private var retrievalStatus as WaypointRetrievalStatus;
    private var retrievalDone as WaypointRetrievalDone;
    private var server as WaypointServerRetriever;

    private var updateTimerSubscription as TimerSubscription;

    function initialize(
        server as WaypointServerRetriever
    ) {
        View.initialize();

        self.server = server;

        self.updateTimerSubscription = AppTimer.subscribeOnUpdate(method(:forceUpdate));

        self.retrievalStatus = new WaypointRetrievalStatus([0, 0]);
        self.retrievalDone = new WaypointRetrievalDone([0, 0]);

        self.retrievalStatus.setOffset([0, -self.retrievalStatus.height() / 2]);
        self.retrievalDone.setOffset([0, -self.retrievalDone.height() / 2]);
    }

    function onLayout(dc as Dc) as Void {
       self.retrievalStatus.layout(dc);
       self.retrievalDone.layout(dc);
    }

    function forceUpdate() as Void {
        self.retrievalStatus.setCode(self.server.deviceCode());
        self.retrievalDone.setCount(self.server.waypoints().size());

        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        var color = Utils.Colors.background;
        dc.setColor(color, color);
        dc.clear();

        if (self.server.stage() != WaypointServerRetriever.Done) {
            self.retrievalStatus.draw(dc);
        } else {
            self.retrievalDone.draw(dc);
        }
    }

    function onShow() as Void {
        self.server.start();
        
        self.updateTimerSubscription.start();
    }

    function retrieveWaypoint() as Void {
        if (self.server.stage() != WaypointServerRetriever.AwaitingWaypoints) {
            return;
        }

        self.server.retrieveWaypoints();
    }

    function onHide() as Void {
        self.server.stop();
        self.updateTimerSubscription.stop();
    }
}
