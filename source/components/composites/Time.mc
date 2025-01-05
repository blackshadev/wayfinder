import Toybox.Graphics;
import Toybox.Lang;

class Time extends RelativeComponent {
    private var timeProvider as TimeProvider;
    private var label as $.Text;
    private var value as $.Text;

    function initialize(timeProvider as TimeProvider, offset as Graphics.Point2D) {
        RelativeComponent.initialize();
        
        self.timeProvider = timeProvider;

        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Graphics.COLOR_LT_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelTime
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_LARGE, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.label.setOffset(offset);
        self.value.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Upwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([self.label, self.value]);
    }

    function layout(dc as Dc) as Void {
        self.label.layout(dc);
        self.value.layout(dc);
    }

    function draw(dc as Dc) as Void {        
        self.value.setText(self.timeProvider.getText());
        
        self.label.draw(dc);
        self.value.draw(dc);
    }
}