/// StringConstants - All user-facing strings in the app
/// This makes localization easier and keeps strings organized
class StringConstants {
  StringConstants._();

  // ============= ONBOARDING =============
  static const String onboarding1Title = 'Discover NGOs';
  static const String onboarding1Description = 
      'Find and connect with verified NGOs working on causes you care about';
  
  static const String onboarding2Title = 'Make a Difference';
  static const String onboarding2Description = 
      'Support causes through donations and volunteer your time';
  
  static const String onboarding3Title = 'Track Your Impact';
  static const String onboarding3Description = 
      'See the real impact of your contributions and stay connected';

  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  // ============= AUTHENTICATION =============
  static const String welcomeBack = 'Welcome Back';
  static const String createAccount = 'Create Account';
  static const String continueAsUser = 'Continue as User';
  static const String continueAsNGO = 'Continue as NGO';
  
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String organizationName = 'Organization Name';
  static const String phoneNumber = 'Phone Number';
  
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String rememberMe = 'Remember Me';
  
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String signupHere = 'Sign Up';
  static const String loginHere = 'Login';
  
  static const String orContinueWith = 'Or continue with';
  static const String google = 'Google';
  static const String facebook = 'Facebook';

  // ============= ROLE SELECTION =============
  static const String selectRole = 'Select Your Role';
  static const String iAmUser = 'I am a User';
  static const String iAmNGO = 'I am an NGO';
  static const String userDescription = 'Discover NGOs and make donations';
  static const String ngoDescription = 'Manage your NGO and campaigns';

  // ============= USER HOME =============
  static const String home = 'Home';
  static const String discover = 'Discover';
  static const String donations = 'Donations';
  static const String profile = 'Profile';
  
  static const String welcomeUser = 'Welcome';
  static const String searchNGOs = 'Search NGOs...';
  static const String categories = 'Categories';
  static const String featuredNGOs = 'Featured NGOs';
  static const String recentlyAdded = 'Recently Added';
  static const String trending = 'Trending';
  static const String viewAll = 'View All';

  // ============= DISCOVER =============
  static const String filterResults = 'Filter Results';
  static const String sortBy = 'Sort By';
  static const String location = 'Location';
  static const String rating = 'Rating';
  static const String applyFilters = 'Apply Filters';
  static const String clearFilters = 'Clear Filters';
  static const String noNGOsFound = 'No NGOs found';
  static const String tryDifferentFilters = 'Try adjusting your filters';

  // ============= NGO DETAIL =============
  static const String about = 'About';
  static const String campaigns = 'Campaigns';
  static const String gallery = 'Gallery';
  static const String contact = 'Contact';
  static const String donate = 'Donate';
  static const String volunteer = 'Volunteer';
  static const String share = 'Share';
  static const String bookmark = 'Bookmark';
  static const String call = 'Call';
  static const String visitWebsite = 'Visit Website';

  // ============= DONATIONS =============
  static const String myDonations = 'My Donations';
  static const String donationHistory = 'Donation History';
  static const String totalDonated = 'Total Donated';
  static const String ngoSupported = 'NGOs Supported';
  static const String livesImpacted = 'Lives Impacted';
  static const String makeADonation = 'Make a Donation';
  static const String selectAmount = 'Select Amount';
  static const String customAmount = 'Custom Amount';
  static const String oneTimeDonation = 'One-Time Donation';
  static const String monthlyDonation = 'Monthly Donation';
  static const String proceedToPay = 'Proceed to Pay';
  static const String noDonationsYet = 'No donations yet';
  static const String startDonating = 'Start making a difference today!';

  // ============= NGO DASHBOARD =============
  static const String dashboard = 'Dashboard';
  static const String analytics = 'Analytics';
  static const String volunteers = 'Volunteers';
  static const String totalDonations = 'Total Donations';
  static const String activeCampaigns = 'Active Campaigns';
  static const String totalVolunteers = 'Total Volunteers';
  static const String recentDonations = 'Recent Donations';
  static const String topCampaigns = 'Top Campaigns';
  static const String viewDetails = 'View Details';

  // ============= CAMPAIGNS =============
  static const String myCampaigns = 'My Campaigns';
  static const String createCampaign = 'Create Campaign';
  static const String editCampaign = 'Edit Campaign';
  static const String campaignTitle = 'Campaign Title';
  static const String campaignDescription = 'Campaign Description';
  static const String goalAmount = 'Goal Amount';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';
  static const String addImages = 'Add Images';
  static const String publishCampaign = 'Publish Campaign';
  static const String saveDraft = 'Save Draft';
  static const String noCampaigns = 'No campaigns yet';
  static const String createFirstCampaign = 'Create your first campaign';

  // ============= PROFILE =============
  static const String myProfile = 'My Profile';
  static const String editProfile = 'Edit Profile';
  static const String settings = 'Settings';
  static const String changePassword = 'Change Password';
  static const String notifications = 'Notifications';
  static const String language = 'Language';
  static const String darkMode = 'Dark Mode';
  static const String aboutUs = 'About Us';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';
  static const String helpCenter = 'Help Center';
  static const String logout = 'Logout';
  static const String deleteAccount = 'Delete Account';

  // ============= COMMON =============
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String update = 'Update';
  static const String submit = 'Submit';
  static const String confirm = 'Confirm';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String ok = 'OK';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';

  // ============= VALIDATION MESSAGES =============
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordsNotMatch = 'Passwords do not match';
  static const String invalidAmount = 'Please enter a valid amount';

  // ============= CONFIRMATION MESSAGES =============
  static const String confirmLogout = 'Are you sure you want to logout?';
  static const String confirmDelete = 'Are you sure you want to delete this?';
  static const String confirmDeleteAccount = 'Are you sure you want to delete your account? This action cannot be undone.';
}

/// Interview Tip:
/// --------------
/// "I centralize all strings in StringConstants for:
/// 
/// 1. **Consistency**: Same text everywhere it's used
/// 2. **Easy Updates**: Change text in one place
/// 3. **Localization Ready**: Easy to implement i18n later
/// 4. **Searchability**: Find where strings are used
/// 5. **Typo Prevention**: Autocomplete prevents typos
/// 
/// In a production app, I would use flutter_localizations
/// or easy_localization package for multi-language support."
