import Toybox.WatchUi;

class AboutMenuBuilder {
    function initialize() {
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({
            :title => WatchUi.loadResource(Rez.Strings.aboutMenuTitle)
        });

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.aboutMenuAppName),
                WatchUi.loadResource(Rez.Strings.AppName),
                null,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                WatchUi.loadResource(Rez.Strings.aboutMenuVersion),
                WatchUi.loadResource(Rez.Strings.AppVersion),
                null,
                {}
            )
        );

        return menu;
    }
}