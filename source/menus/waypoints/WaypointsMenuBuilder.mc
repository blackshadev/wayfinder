import Toybox.WatchUi;
import Toybox.Lang;

class WaypointsMenuBuilder {
	private var waypoint as WaypointsController;

	function initialize(waypoint as WaypointsController) {
		self.waypoint = waypoint;
	}

	public function build() as WatchUi.Menu2 {
		var menu = new WatchUi.Menu2({ :title => Rez.Strings.menuWaypointsTitle });

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuReceiveWaypoints,
				Rez.Strings.menuReceiveWaypointsInfo,
				WaypointsMenuDelegate.WAYPOINTS_RECEIVE,
				{}
			)
		);


		var noLocationLabel = null as String?;
		if (!self.waypoint.isSettable()) {
			noLocationLabel = Rez.Strings.menuSetWaypointNoLocation;
		}

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuSetReturnWaypoint,
				noLocationLabel,
				WaypointsMenuDelegate.WAYPOINT_SET_RETURN,
				{}
			)
		);

		var waypointCountLabel = null as String?;
		if (!self.waypoint.isSettable()) {
			waypointCountLabel = Lang.format("$1$ waypoints", [self.waypoint.count()]);
		}

		menu.addItem(
			new MenuItem(
				Rez.Strings.menuClearWaypoints,
				waypointCountLabel,
				WaypointsMenuDelegate.WAYPOINTS_CLEAR,
				{}
			)
		);

		return menu;
	}
}

