import Toybox.Graphics;
import Toybox.Lang;

class WaypointArrows extends RelativeComponent {
    private var _waypoints as WaypointsController;

    private var _currentWaypoint as FilledArrow;
    private var _line as RadialLine;
    private var _returnArrow as HollowArrow;
    private var _isAbsolute as Boolean;

    function initialize(
        settings as SettingsController,
        waypoints as WaypointsController,
        isAbsolute as Boolean
    ) {
        RelativeComponent.initialize();

        self._waypoints = waypoints;
        self._isAbsolute = isAbsolute == true;

        self._currentWaypoint = new FilledArrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_GREEN
        });
        self._returnArrow = new HollowArrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_DK_BLUE
        });

        self._line = new RadialLine({
            :size => 2,
            :color => Graphics.COLOR_LT_GRAY
        });
    }

    public function update() as Void {
        var currentWaypoint = self._waypoints.currentWaypoint();
        if (currentWaypoint != null && self._waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.setAngle(self._isAbsolute ? currentWaypoint.absoluteAngle() : currentWaypoint.angle());
        }

        var returnWaypoint = self._waypoints.returnWaypoint();
        if (returnWaypoint != null && self._waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.setAngle(self._isAbsolute ? returnWaypoint.absoluteAngle() : returnWaypoint.angle());
            self._line.setAngle(self._isAbsolute ? returnWaypoint.absoluteAngle() : returnWaypoint.angle());
        }
    }

    public function layout(dc as Dc) as Void {
        self._currentWaypoint.layout(dc);
        self._returnArrow.layout(dc);
        self._line.layout(dc);
    }

    public function draw(dc as Dc) as Void {
        if (self._waypoints.shouldShowCurrentWaypoint()) {
            self._currentWaypoint.draw(dc);
        }

        if (self._waypoints.shouldShowReturnWaypoint()) {
            self._returnArrow.draw(dc);
            self._line.draw(dc);
        }
    }
}