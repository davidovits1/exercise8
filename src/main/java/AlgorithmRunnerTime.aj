
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import java.util.HashMap;
import java.util.Map;

@Aspect
public class AlgorithmRunnerTime {

    private DurationTimeBasic durationTime;
    private HashMap<String, HelpRunTime> RunnerTimes;

    public AlgorithmRunnerTime() {
        durationTime = new DurationTimeBasic();
        RunnerTimes = new HashMap<>();
    }

    private void Add(String ClassName, Double DurationTime) {
        if (RunnerTimes.containsKey(ClassName))
            RunnerTimes.put(ClassName, RunnerTimes.get(ClassName).newRunTime(DurationTime));

        else
            RunnerTimes.put(ClassName, HelpRunTime.GetInstance(DurationTime, ClassName));
    }

    @Pointcut("execution(* sort*(..))")
    private void selectAllSort() {
    }

    @Before("selectAllSort()")
    public void beforeRunningTime() {
        durationTime.startTime = System.currentTimeMillis();
    }

    @After("selectAllSort()")
    public void afterRunningTime(JoinPoint joinPoint) {
        durationTime.endTime = System.currentTimeMillis();
        Double _durationTime = durationTime.getDuration();
        String functionName = joinPoint.getSignature().getName() + " "
                + joinPoint.getThis().toString().split("@")[0];
        Add(functionName, _durationTime);
        durationTime.ResetTime();
    }

    @Pointcut("execution(* runAlgorithms*(..))")
    private void selectAllSortsTime() {
    }

    @After("selectAllSortsTime()")
    public void AfterAllSorts() {
        double sumOfRunning = RunnerTimes.values().stream().map(r -> r.Time).mapToDouble(t -> t).sum();
        System.out.println("Total time of running all sort functions was " + sumOfRunning + " ms \n");

        for (Map.Entry<String, HelpRunTime> helpRunTimeEntry : RunnerTimes.entrySet()) {
            System.out.println(helpRunTimeEntry.getValue().toString("sort"));
        }
        System.out.println();
    }
}


