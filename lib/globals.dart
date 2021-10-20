List content = [];
Map symbolContent = {};

String searchText = '';
bool isInSearchField = false;

int pageNumber = 1;
int itemsNumber = 0;
late bool hasNextPage = false;

late int tappedIndex;

bool isFetching = false;
bool isFetchingMore = false;
bool isFetchingDetails = false;
