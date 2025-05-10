import Toybox.Graphics;
import Toybox.Lang;

class CurrentSpeed extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var label as $.Text;
    private var value as $.Text;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelSpeed
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_LARGE, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT 
        });

        self.setValue(null);
    }

    function setValue(value as SpeedValue?) as Void {
        if (value == null) {
            self.value.setText("--");
            return;
        }

        var currentSpeed = self.unitConverter.speedFromMS(value.current);
        self.value.setText(currentSpeed.format("%0.1f"));
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
        self.label.draw(dc);
        self.value.draw(dc);
    }
}