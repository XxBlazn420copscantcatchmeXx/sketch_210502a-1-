import java.util.Comparator;

class AlphabeticComparator implements Comparator<State> {
  public int compare(State c1, State c2) {
    return c1.getName().compareTo(c2.getName());
  }
}
