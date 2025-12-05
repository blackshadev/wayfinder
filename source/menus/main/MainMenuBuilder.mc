import Toybox.WatchUi;
import Toybox.Lang;

class MainMenuBuilder {

    function initialize() {
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({ :title => "Wayfinder" });

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menuOpenWaypoints),
                null,
                MainMenuDelegate.WAYPOINTS_OPEN_ID,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menuOpenSettings),
                null,
                MainMenuDelegate.SETTINGS_OPEN_ID,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menuWindDirectionTitle),
                null,
                MainMenuDelegate.WINDDIRECTION_OPEN_ID,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.menuOpenAbout),
                null,
                MainMenuDelegate.ABOUT_OPEN_ID,
                {}
            )
        );

        return menu;
    }
}