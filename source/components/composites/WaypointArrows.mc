import Toybox.Graphics;

class WaypointArrows extends RelativeComponent {
    private var waypoints as WaypointsController;

    private var _currentWaypoint as Arrow;
    private var _returnArrow as Arrow;

    function initialize(
        settings as SettingsController,
        waypoints as WaypointsController
    ) {
        RelativeComponent.initialize();

        self.waypoints = waypoints;

        self._currentWaypoint = new Arrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_GREEN
        });
        self._returnArrow = new Arrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_DK_BLUE
        });
    }

    public function update() as Void {
        var currentWaypoint = self.waypoints.currentWaypoint();
        if (currentWaypoint != null && self.waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.setAngle(currentWaypoint.angle());
        }

        var returnWaypoint = self.waypoints.returnWaypoint();
        if (returnWaypoint != null && self.waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.setAngle(returnWaypoint.angle());
        }
    }

    public function layout(dc as Dc) as Void {
        self._currentWaypoint.layout(dc);
        self._returnArrow.layout(dc);
    }

    public function draw(dc as Dc) as Void {
        if (self.waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.draw(dc);
        }

        if (self.waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.draw(dc);
        }
    }
}