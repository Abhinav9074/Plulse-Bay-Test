abstract class TradieEvent{}

class TradieDateFetchEvent extends TradieEvent{
  final String location;

  TradieDateFetchEvent({required this.location});
}