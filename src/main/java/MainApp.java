import org.jboss.weld.environment.se.Weld;
import org.jboss.weld.environment.se.WeldContainer;

import javax.enterprise.inject.Produces;
import javax.inject.Named;
import java.util.Random;

public class MainApp {
    private static WeldContainer container = new Weld().initialize();

    public static void main(String[] args) {
        AlgorithmRunner algorithmRunner = container.select(AlgorithmRunner.class).get();
        algorithmRunner.runAlgorithms();
    }

    // Produces for RandomSortingAlgorithm.
    @Produces
    public @Named("RandomSortingAlgorithm") SortingAlgorithm<Integer> makeRandomSortingAlgorithm() {
        Random random = new Random(System.currentTimeMillis());
        SortingAlgorithm<Integer> sortAlg = null;
        switch (random.nextInt(4)) {
            case 0:
                sortAlg = container.select(QuickSort.class).get();
                break;
            case 1:
                sortAlg = container.select(MergeSort.class).get();
                break;
            case 2:
                sortAlg = container.select(BubbleSort.class).get();
                break;
            case 3:
                sortAlg = container.select(InsertionSort.class).get();
        }
        return sortAlg;
    }

    // Produces for BubbleSort.
    @Produces
    public @Named("SortingAlgorithmHigh") SortingAlgorithm<Integer> QuickSortGeneratorHigh() {
        return container.select(BubbleSort.class).get();
    }

    // Produces for QuickSort.
    @Produces
    public @Named("SortingAlgorithmLow") SortingAlgorithm<Integer> QuickSortGeneratorLow() {
        return container.select(QuickSort.class).get();
    }

    // Produces for NumberOfElements.
    @Produces
    public @Sweet Integer GetNumberOfElements() {
        return 10000;
    }
}

