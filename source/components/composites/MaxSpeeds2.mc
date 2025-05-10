import Toybox.Graphics;
import Toybox.Lang;

class MaxSpeeds2 extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var max30s as $.Text;
    private var max as $.Text;
    private var max30sLabel as $.Text;
    private var maxLabel as $.Text;
    private var topOffset as Layout.Offset;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.topOffset = new Layout.Offset({
            :offset => [offset[0], offset[1]],
            :size => [0, Utils.Fonts.getFontHeight(Graphics.FONT_XTINY)]
        });
        self.max30s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        self.max = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.max30sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelMaxSpeed30s
        });
        self.maxLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelMaxSpeed
        });

        self.setMaxSpeeds(null);
        self.setSpeed(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.topOffset.setOffset(offset);
        self.max30sLabel.setOffset(offset);
        self.maxLabel.setOffset(offset);
        self.max30s.setOffset(offset);
        self.max.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.topOffset,
            new Layout.Row([ self.max30sLabel, self.max30s ]),
            new Layout.Row([ self.maxLabel, self.max ])
        ]);
    }

    function setMaxSpeeds(maxSpeed as MaxSpeedValues?) as Void {
        if (maxSpeed == null) {
            self.max30s.setText("--");
            return;
        }

        var max30s = self.unitConverter.speedFromMS(maxSpeed.speed30s);
        self.max30s.setText(max30s.format("%.01f"));
    }

    function setSpeed(speed as SpeedValue?) as Void {
        if (speed == null) {
            self.max.setText("--");
            return;
        }

        var max = self.unitConverter.speedFromMS(speed.max);
        self.max.setText(max.format("%.01f"));
    }

    function layout(dc as Dc) as Void {
        self.max30sLabel.layout(dc);
        self.maxLabel.layout(dc);

        var w = self.maxLabel.calculateTextWidth(dc);
        self.max30s.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);
        self.max.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);

        self.max30s.layout(dc);
        self.max.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.max30s.draw(dc);
        self.max.draw(dc);

        self.max30sLabel.draw(dc);
        self.maxLabel.draw(dc);
    }
}