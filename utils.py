NON_US_KEYWORDS = [
    # Countries
    "uk", "united kingdom", "england", "scotland", "wales",
    "canada", "ontario", "toronto", "vancouver", "montreal",
    "india", "bangalore", "bengaluru", "mumbai", "delhi", "hyderabad", "pune", "chennai",
    "germany", "berlin", "munich", "frankfurt",
    "france", "paris",
    "netherlands", "amsterdam",
    "spain", "madrid", "barcelona",
    "ireland", "dublin",
    "australia", "sydney", "melbourne",
    "singapore",
    "japan", "tokyo",
    "brazil", "sao paulo",
    "mexico", "mexico city", "cdmx",
    "israel", "tel aviv",
    "uae", "dubai", "abu dhabi",
    "qatar", "doha",
    "saudi arabia", "riyadh",
    "sweden", "stockholm",
    "denmark", "copenhagen",
    "finland", "helsinki",
    "norway", "oslo",
    "switzerland", "zurich",
    "austria", "vienna",
    "poland", "warsaw",
    "romania", "bucharest",
    "philippines", "manila",
    "indonesia", "jakarta",
    "south korea", "seoul",
    "china", "beijing", "shanghai",
    "hong kong",
    "taiwan", "taipei",
    "new zealand", "auckland",
    "colombia", "bogota",
    "argentina", "buenos aires",
    "chile", "santiago",
    "panama",
]

def is_us_location(location: str) -> bool:
    if not location:
        return True  # no location = assume remote US
    loc = location.lower()
    return not any(keyword in loc for keyword in NON_US_KEYWORDS)
