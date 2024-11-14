let scamPages = [
    // Facebook pages (without the https://facebook.com/ part)
    'NetflixNepalEverydayOnline',
    'profile.php?id=61564754708972',
    'profile.php?id=61565844092962',
    'profile.php?id=61563450360037',
    'profile.php?id=100092392238271',
    // Instagram pages (without the https://instagram.com/ part)
    'hamroflix_nepal',
    'netflixnepali__'
];

// Function to check if current URL matches any scam pages
function checkForScamPage(url) {
    // Convert URL to lowercase for case-insensitive matching
    const lowerUrl = url.toLowerCase();

    for (const page of scamPages) {
        if (lowerUrl.includes('facebook.com/' + page.toLowerCase()) ||
            lowerUrl.includes('instagram.com/' + page.toLowerCase())) {
            return true;
        }
    }
    return false;
}

// Listen for URL changes
browser.webNavigation.onCompleted.addListener((details) => {
    if (checkForScamPage(details.url)) {
        // Show notification
        browser.notifications.create({
            type: 'basic',
            iconUrl: 'images/police.jpg',
            title: 'Scam Alert!',
            message: 'Warning: This page has been reported as SCAM by the community.'
        });
    }
}, {
    url: [
        { hostEquals: 'www.facebook.com' },
        { hostEquals: 'facebook.com' },
        { hostEquals: 'www.instagram.com' },
        { hostEquals: 'instagram.com' }
    ]
});

// Add functionality to update scam pages list
browser.storage.local.get('customScamPages', (result) => {
    if (result.customScamPages) {
        scamPages = scamPages.concat(result.customScamPages);
    }
});