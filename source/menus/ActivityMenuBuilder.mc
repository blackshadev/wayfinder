import Toybox.WatchUi;

class ActivityMenuBuilder {
    private var activity as ActivityController;

    function initialize(activity as ActivityController) {
        self.activity = activity;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({:title=>"Activity"});

        if (self.activity.isPaused()) {
            menu.addItem(
                new MenuItem(
                    "Resume",
                    null,
                    ActivityMenuDelegate.ACTIVITY_RESUME,
                    {}
                )
            );
        } else {
           menu.addItem(
                new MenuItem(
                    "Pause",
                    null,
                    ActivityMenuDelegate.ACTIVITY_PAUSE,
                    {}
                )
            ); 
        }
        
        menu.addItem(
            new MenuItem(
                "Save",
                null,
                ActivityMenuDelegate.ACTIVITY_SAVE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                "Discard",
                null,
                ActivityMenuDelegate.ACTIVITY_DISCARD,
                {}
            )
        ); 

        return menu;
    }
}