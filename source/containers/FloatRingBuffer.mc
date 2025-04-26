import Toybox.Lang;

class FloatRingBuffer {
    private var lastIndex as Number = -1;
    private var data as Array<Float> = [];
    private var size as Number;

    public function initialize(size as Number, defaultValue as Float) {
        self.size = size;
        
        for (var iX = 0; iX < size; iX++) {
            self.data.add(defaultValue);
        }
    }

    public function add(value as Float) as Void {
        self.lastIndex = (self.lastIndex + 1) % self.size;
        self.data[self.lastIndex] = value;
    }

    public function max(range as Number) as Float {
        range = Utils.min(self.size, range);

        var iX = self.lastIndex < 0 ? self.size - 1 : self.lastIndex;
        var max = self.data[iX];

        while (range > 0) {
            if (max < self.data[iX]) {
                max = self.data[iX];
            }

            range -= 1;
            iX = (iX - 1) % self.size;
            if (iX < 0) {
                iX = self.size - 1;
            }
        }

        return max;
    }
}