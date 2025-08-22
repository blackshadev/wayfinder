import Toybox.Lang;
import Toybox.Graphics;

class BusyIndicator extends RelativeComponent {
    private var _tick as Number = 0;
    private var dots as Array<String> = [".", "..", "...", "....", "....."];
    private var _text as Text;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self._text = new Text({
            :offset => [0, 0],
            :font => Graphics.FONT_XTINY,
            :color => Utils.Colors.greyForeground,
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :text => self.dots[self.dots.size() - 1]
        });

        self.setOffset([0, 0]);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self._text.setOffset(offset);
    }

    function layout(dc as Dc) as Void {
        self._text.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self._tick = (self._tick + 1) % self.dots.size();

        self._text.setText(self.dots[self._tick]);
        self._text.draw(dc);
    }

    public function height() as Number { 
        return self._text.height();
    }
}