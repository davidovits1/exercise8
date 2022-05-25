import javax.inject.Inject;
import javax.inject.Named;
import java.util.Random;

public class AlgorithmRunner {
    // Injects the instances by dependency injection with named which tells which Products to contact.
    @Inject
    @Named("SortingAlgorithmHigh")
    SortingAlgorithm<Integer> quadraticAlgorithm;

    @Inject
    @Named("SortingAlgorithmLow")
    SortingAlgorithm<Integer> nlognAlgorithm;

    @Inject
    @Named("RandomSortingAlgorithm")
    SortingAlgorithm<Integer> randomAlgorithm1;

    @Inject
    @Named("RandomSortingAlgorithm")
    SortingAlgorithm<Integer> randomAlgorithm2;

    @Inject
    @Sweet
    int numberOfElements;

    public void runAlgorithms() {
        Random rand = new Random();
        Integer[] ints = rand.ints(1, Integer.MAX_VALUE)
                .distinct()
                .limit(numberOfElements)
                .boxed()
                .toArray(Integer[]::new);
        Integer[] intsClone = ints.clone();
        quadraticAlgorithm.sort(intsClone);
        intsClone = ints.clone();
        nlognAlgorithm.sort(intsClone);
        intsClone = ints.clone();
        randomAlgorithm1.sort(intsClone);
        intsClone = ints.clone();
        randomAlgorithm2.sort(intsClone);
    }
}
