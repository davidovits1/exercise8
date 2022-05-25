//Class for calculate duration time.
public class DurationTimeBasic {
    public double startTime;
    public double endTime;

    // Function that return the time between start to end.
    public double getDuration() {
        return endTime - startTime;
    }

    // Function that reset the time for next calculation.
    public void ResetTime() {
        startTime = endTime = 0;
    }
}
