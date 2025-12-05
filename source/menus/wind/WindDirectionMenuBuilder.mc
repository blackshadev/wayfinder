import Toybox.WatchUi;
import Toybox.Lang;

class WindDirectionMenuBuilder {
    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({ :title => Rez.Strings.menuWindDirectionTitle });

        menu.addItem(
            new MenuItem(
                Rez.Strings.menuWindUnset,
                null,
                WindDirectionMenuDelegate.WIND_UNSET,
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Rez.Strings.menuWindForecast,
                null,
                WindDirectionMenuDelegate.WIND_FORECAST,
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Rez.Strings.menuWindFlip,
                null,
                WindDirectionMenuDelegate.WIND_FLIP,
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Rez.Strings.menuWindSetCurrent,
                null,
                WindDirectionMenuDelegate.WIND_SET_CURRENT,
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                Rez.Strings.menuWindSetAway,
                null,
                WindDirectionMenuDelegate.WIND_SET_AWAY,
                {}
            )
        );
        return menu;
    }
}
