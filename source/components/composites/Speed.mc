import Toybox.Graphics;
import Toybox.Lang;

class Speed extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var title as $.Text;
    private var current as $.Text;
    private var max as $.Text;
    private var currentLabel as $.Text;
    private var maxLabel as $.Text;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.title = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelSpeed
        });
        
        self.currentLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelSpeedCurrent
        });
        self.maxLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelSpeedMaximum
        });

        self.current = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
        self.max = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });

        self.setValue(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.currentLabel.setOffset(offset);
        self.maxLabel.setOffset(offset);
        self.current.setOffset(offset);
        self.max.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([self.current, self.currentLabel]),
            new Layout.Row([self.max, self.maxLabel]),
        ]);
    }

    function setValue(value as SpeedValue?) as Void {
        if (value == null) {
            self.current.setText("--");
            self.max.setText("--");
            return;
        }

        var current = self.unitConverter.speedFromMS(value.current);
        var max = self.unitConverter.speedFromMS(value.max);

        self.current.setText(current.format("%.01f"));
        self.max.setText(max.format("%.01f"));
    }

    function layout(dc as Dc) as Void {
        self.title.layout(dc);
        self.currentLabel.layout(dc);
        self.maxLabel.layout(dc);

        var w = self.maxLabel.calculateTextWidth(dc);
        self.current.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);
        self.max.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);
        
        self.current.layout(dc);
        self.max.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.title.draw(dc);
        self.current.draw(dc);
        self.max.draw(dc);
        self.currentLabel.draw(dc);
        self.maxLabel.draw(dc);
    }
}