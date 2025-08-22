import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Position;
import Toybox.Communications;

class ReceiveWaypointsView extends WatchUi.View {
    private var deviceCode as WaypointServerDeviceCode;
    private var server as WaypointServerRetriever;

    private var updateTimerSubscription as TimerSubscription;

    function initialize(
        server as WaypointServerRetriever
    ) {
        View.initialize();

        self.server = server;

        self.updateTimerSubscription = AppTimer.subscribeOnUpdate(method(:forceUpdate));

        self.deviceCode = new WaypointServerDeviceCode([0, 0]);

        self.deviceCode.setOffset([0, -self.deviceCode.height() / 2]);
    }

    function onLayout(dc as Dc) as Void {
       self.deviceCode.layout(dc);
    }

    function forceUpdate() as Void {
        System.println(self.server.deviceCode());
        self.deviceCode.setCode(self.server.deviceCode());

        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        var color = Utils.Colors.background;
        dc.setColor(color, color);
        dc.clear();

        self.deviceCode.draw(dc);
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
