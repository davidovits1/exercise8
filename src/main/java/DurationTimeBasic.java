public class DurationTimeBasic {
    public double startTime;
    public double endTime;

    public double getDuration() {
        return endTime - startTime;
    }

    public void ResetTime() {
        startTime = endTime = 0;
    }
}
