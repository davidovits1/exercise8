
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import java.util.HashMap;
import java.util.Map;

@Aspect
public class AlgorithmRunnerTime {

    // DurationTimeBasic for calculate any time of function that running.
    private DurationTimeBasic durationTime;

    //Save time of all runs of a specific function.
    // The key is the name of the class + the name of the function
    // and the value is the time and the number of times it is run.
    private HashMap<String, HelpRunTime> RunnerTimes;

    public AlgorithmRunnerTime() {
        durationTime = new DurationTimeBasic();
        RunnerTimes = new HashMap<>();
    }

    // Add or update new running.
    private void AddOrUpdate(String ClassName, Double DurationTime) {
        if (RunnerTimes.containsKey(ClassName))
            RunnerTimes.put(ClassName, RunnerTimes.get(ClassName).newRunTime(DurationTime));

        else
            RunnerTimes.put(ClassName, HelpRunTime.GetInstance(DurationTime, ClassName));
    }

    // pointcut for all sorting function.
    @Pointcut("execution(* sort*(..))")
    private void selectAllSort() {
    }

    // The function is called before each sort run.
    @Before("selectAllSort()")
    public void beforeRunningTime() {
        durationTime.startTime = System.currentTimeMillis();
    }

    // The function is called after each sort run.
    @After("selectAllSort()")
    public void afterRunningTime(JoinPoint joinPoint) {
        durationTime.endTime = System.currentTimeMillis();

        // The duration Time.
        Double _durationTime = durationTime.getDuration();

        String functionName = joinPoint.getSignature().getName() + " "
                + joinPoint.getThis().toString().split("@")[0];

        // Add or update the new run time.
        AddOrUpdate(functionName, _durationTime);

        durationTime.ResetTime();
    }

    // pointcut for all running function.
    @Pointcut("execution(* runAlgorithms*(..))")
    private void selectAllSortsTime() {
    }

    // The function is called after all sort functions runs.
    @After("selectAllSortsTime()")
    public void AfterAllSorts() {

        // The time of all sort functions.
        double sumOfRunning = RunnerTimes.values().stream().map(r -> r.Time).mapToDouble(t -> t).sum();
        System.out.println("Total time of running all sort functions was " + sumOfRunning + " ms \n");

        // // The time of all running of one sort function.
        for (Map.Entry<String, HelpRunTime> helpRunTimeEntry : RunnerTimes.entrySet()) {
            System.out.println(helpRunTimeEntry.getValue().toString("sort"));
        }
        System.out.println();
    }
}


