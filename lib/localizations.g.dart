// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

// ignore_for_file: camel_case_types

class AppLocalization {
  AppLocalization(this.locale) : labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalization_Labels> languages = {
    Locale.fromSubtags(languageCode: 'en'): AppLocalization_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: 'Monday',
          tuesday: 'Tuesday',
          wednesday: 'Wednesday',
          thursday: 'Thursday',
          friday: 'Friday',
          saturday: 'Saturday',
          sunday: 'Sunday',
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: 'January',
          february: 'February',
          march: 'March',
          april: 'April',
          may: 'May',
          june: 'June',
          july: 'July',
          august: 'August',
          september: 'September',
          october: 'October',
          november: 'November',
          december: 'December',
        ),
      ),
      screens: AppLocalizations_Labels_Screens(
        home: 'Home',
        deals: 'Deals',
        goals: 'Rewards',
        profile: 'Me',
        settings: 'Settings',
        notifications: 'Notifications',
      ),
      richtext: AppLocalizations_Labels_Richtext(
        signUpCaption: ({tagOneOpen, tagOneClose, tagTwoOpen, tagTwoClose}) =>
            '''Sign up for Yulii and find out how you can ${tagOneOpen}have fun${tagOneClose} doing daily chores ${tagTwoOpen}with family or friends!${tagTwoClose}''',
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstname}) => '''Hi, ${firstname}!''',
      ),
      labels: AppLocalizations_Labels_Labels(
        lastname: 'Last name',
        firstname: 'First name',
        email: 'Email',
        password: 'Password',
        dealName: 'Deal name',
        description: 'Description',
        code: 'Code',
        toSignIn: 'Sign in',
        signIn: 'Sign in',
        toSignUp: 'Sign up',
        signUp: 'Sign up',
        toSignOut: 'Sign out',
        alreadyHaveAccount: 'I already have an account',
        forgottenPassword: 'Forgot your password ?',
        submiting: 'Submitting...',
        retrievePassword: 'Recover password',
        verifyCode: 'Verify code',
        back: 'Back',
        passwordConfirmation: 'Password confirmation',
        newPassord: 'New password',
        cancel: 'Cancel',
        createNewPassord: 'Create new password',
        dontHaveAnAccount: 'You do not have an account ?',
        clickOnVerificationLink:
            'Click on the verification link sent to your email address. When it\'s done, press the button below to continue.',
        sendPasswordReset:
            'Enter your e-mail adress. We will send you a password reset link if you are registered.',
        passwordResetEmailSent: 'Password reset email sent. Check your inbox.',
        backToLogin: 'Back to login',
        loggedInAs: 'Logged in as',
        all: 'All',
        accountSettings: 'Account settings',
        about: 'About',
        aboutOf: ({name}) => '''About ${name}''',
        qa: 'Q&A',
        terms: 'Terms and conditions',
        privacyPolicy: 'Privacy Policy',
        myLastDeals: 'My last deals',
        myGoals: 'My rewards',
        myDeals: 'My deals',
        allGoals: 'All rewards',
        allDeals: 'All deals',
        goalName: 'Reward name',
        members: 'Members',
        confirm: 'Confirm',
        shootingTips: 'Tap to take photo. Long press to record video.',
        languageName: 'English',
        language: 'Language',
        suggestTo: 'Suggest to',
        suggestedTo: 'Suggested to',
        assignTo: 'Assign to',
        assignedTo: 'Assigned to',
        requiredPoints: 'Required points',
        points: 'Points',
        nameOrEmail: 'Name or email',
        status: 'Statut',
        done: 'Done',
        declined: 'Refused',
        pending: 'Pending',
        opened: 'To do',
        mysteryGift: 'Mystery gift !',
        mysteryGiftQuestionMark: 'Mystery gift ?',
        date: 'Date',
        tutorial: 'Tutorial',
        enterFriendEmail: 'Enter your friend\'s email address',
        relatedDeals: 'Related Deal(s)',
        friends: 'Friends',
        myStats: 'My stats',
        pointsPlaceholder: ({points}) => '''${points} points''',
        reward: 'Gift',
        rewardPro: 'Pro Gift',
        deal: 'Deal',
        tasksAssignedTo: ({username}) => '''Deals assigned to ${username}''',
        tasksSuggeredBy: ({username}) => '''Deals suggested by ${username}''',
        labelRequired: 'Required',
        profilePicture: 'Profile picture',
        deletePicture: 'Delete picture',
        takePicture: 'Take a picture',
        takeVideo: 'Take a video',
        gallery: 'Gallery',
        camera: 'Camera',
        noDeal: 'No deal',
        noReward: 'No reward',
        dealCountPlaceholder: (condition, {count}) {
          if (condition == Plural.one) return '''${count} deal''';
          if (condition == Plural.zero) return '''${count} deal''';
          if (condition == Plural.multiple) return '''${count} deals''';
          throw Exception();
        },
        filter: 'Filter',
        ongoingRewards: 'Ongoing rewards',
        claimedRewards: 'Claimed rewards',
        requiredPointsCount: 'Number of points required',
        rewardDescription:
            'The "normal gift mode" allows you to offer friends and family rewards to unlock with the points gained from doing deals.',
        proRewardDescription:
            'The "pro gift mode" allows you to link deals that will be mandatory for friends and family to accomplish in order to unlock the reward.',
        myMessages: 'My messages',
        selectAFriend: 'Select a friend',
        selectPhoto: 'Select a photo',
        selectVideo: 'Select a video',
        confirmMediaUpload: 'Are you sure you are sending the file ?',
        confirmFriendDeletion:
            'You are about to delete a friend. You confirm ?',
        confirmation: 'Confirmation',
        newItem: 'New',
        claimedItem: 'Claimed',
      ),
      hints: AppLocalizations_Labels_Hints(
        lastname: 'Your last name',
        firstname: 'Your first name',
        email: 'Your email',
        password: 'Your password',
        code: 'Enter code',
        passwordConfirmation: 'Enter password confirmation',
        newPassord: 'Enter new password',
        typeAMessage: 'Type a message',
      ),
      notifications: AppLocalizations_Labels_Notifications(
        invitation: ({user}) => '''${user} sent you an invitation.''',
        invitationAccepted: ({user}) =>
            '''${user} has accepted your invitation.''',
        newMessage: ({user}) => '''${user} has sent you a new message''',
        validationRequestDeal: ({name, title}) =>
            '''${name} needs approval for ${title}''',
        approvedDeal: ({name, title}) =>
            '''${name} approved the deal ${title}''',
        declinedDeal: ({name, title}) =>
            '''${name} declined the deal ${title}''',
        suggestedDeal: ({name, title}) =>
            '''${name} suggested a reward ${title}''',
        assignedDeal: ({name, title}) =>
            '''${name} assigned you a reward ${title}''',
        assignedMysteryDeal: ({name}) =>
            '''${name} assigned you a mystery reward''',
        newReward: ({goalName}) => '''You have a new reward: ${goalName}''',
        newDeal: ({taskName}) => '''You have a new task : ${taskName}''',
        doneDeal: ({name, taskName}) =>
            '''${name} has finished the deal : ${taskName}''',
        claimReward: ({name, goalName}) =>
            '''${name} wants to claim a reward: ${goalName}''',
        acceptedSuggestedReward: ({goalName}) =>
            '''The suggested goal has been accepted : ${goalName}''',
        declinedSuggestedReward: ({goalName}) =>
            '''The suggested goal has been declined : ${goalName}''',
      ),
      errors: AppLocalizations_Labels_Errors(
        validations: AppLocalizations_Labels_Errors_Validations(
          names: ({field}) =>
              '''${field} must contains only letters and spaces between words''',
          minimum: ({field, min}) =>
              '''${field} name must be at least ${min} characters long''',
          maximum: ({field, max}) =>
              '''${field} must contain a maximum of ${max} characters''',
          length: ({field, min, max}) =>
              '''${field} must be between ${min} and ${max} characters''',
          invalidEmail: 'Email is not valid',
          alreadyInUseEmail: 'This email is already registered',
          notRegisteredEmail: 'This email is not registered',
          passwordLength: ({min}) =>
              '''Password must be at least ${min} characters long''',
          passwordRegex:
              'Password must contains at least 1 number and 1 letter',
          invalidCredentials: 'Invalid credentials',
          disabledUser: 'Sorry, your account has been revoked',
          fieldRequired: ({field}) => '''${field} is required''',
          sameEmailThanYou: 'This email is the same as yours',
          alreadyFriend: 'You are already friends with this user',
        ),
        forms: AppLocalizations_Labels_Errors_Forms(
          invalid: 'Invalid form',
        ),
        exceptions: AppLocalizations_Labels_Errors_Exceptions(
          unexpected: 'Unexpected error',
          tooManyRequests: 'Too many requests. Try again later',
          operationNotAllowed: 'Operation not allowed',
          networkConnectionFailed: 'Network connection failed',
        ),
      ),
      events: AppLocalizations_Labels_Events(
        loading: 'Loading',
        loadingAlternative: 'Loading...',
        submitting: 'Submitting',
        checking: 'Checking...',
        submittingAlternative: 'Submitting...',
      ),
      actions: AppLocalizations_Labels_Actions(
        check: 'Check',
        resendEmailVerification: 'Resend verification',
        ignore: 'Skip',
        accept: 'Accept',
        addFriend: 'Add a friend / family',
        addDeal: 'Add a deal',
        addGoal: 'Add a reward',
        edit: 'Edit',
        save: 'Save',
        signOut: 'I sign out',
        searchDeal: 'Search a deal',
        searchGoal: 'Search a reward',
        searchFriend: 'Search a friend',
        sendInvitation: 'Send invitation',
        claimReward: 'Claim reward',
        editReward: 'Edit reward',
        editTask: 'Edit deal',
        delete: 'Delete',
      ),
      notice: AppLocalizations_Labels_Notice(
        emailNotVerified: 'Email is not verified',
        emailSent: 'Email sent',
        waitInSeconds: ({seconds}) =>
            '''Wait ${seconds}s before trying again''',
        beforeSignOut: 'You are about to log out. Do you confirm ?',
        dealsCompleted: 'deals completed',
      ),
      longText: AppLocalizations_Labels_LongText(
        about:
            'Yulii is the redefinition of mobile challenges for family and friends.\n\nOn This mobile app game, you will be introduced to two side, the rewarder and the player. As the rewarder you get to create one or many rewards for the player with each one containing a number of points created by you. Alongside those rewards you also create tasks that the player must achieve to obtain of those rewards. Each task containing a number of points created as well by you.\n\nAs the player the objective is to complete as much tasks as possible in order to get enough points to obtain one of those rewards established by the rewarder.\n\nYou will also be able to regularly consult your account in order for you to see how many points you have and how much more you need to obtain one of those rewards.\n\nAs you play the game along, you get to unvover different types of options such as:\n\n- The  ?? Timer ?? where the rewarder gets to put a time limit for certain tasks (or all of them) to be accomplished.\n\n- The ?? Mystery Gift ?? where the rewarder offers the player a mystery reward with the condition of specific tasks completed in order to obtain it.\n\n- And the ?? Treaty Agreement ?? where the player can suggest the reward of his/her dreams to the rewarder and come to an agreement of the number of points needed in order to get it.\n\n\nWith all of these notions out of the way, let the fun begin !',
      ),
      notices: AppLocalizations_Labels_Notices(
        dealCreated: 'Deal created !',
        goalCreated: 'Reward created !',
        invitationSent: 'Invitation sent',
        mysteryGiftNoticeAtCreation:
            'The name of the gift will be hidden until the member assigned with the gift has enough points to unlock it.',
        mysteryProGiftNoticeAtCreation:
            'The name of the gift will be hidden until the member assigned with the gift accomplishes all of the linked deals.',
        cannotSelectTaskBeforeMember: 'You must first select a member',
        noDataFound: 'No data found',
        claimSent: 'Claim sent',
        alreadyClaimed: 'You have already claimed this reward',
        notEnoughPoints: 'You don\'t have enough points to claim this reward',
        editDone: 'Successfully edited',
        noNotification: 'No notification',
        linkedRewardIsStillPending:
            'The linked gift is still pending validation',
        unsupportedLink: 'Link type not supported',
      ),
      onboarding: AppLocalizations_Labels_Onboarding(
        pageOne: AppLocalizations_Labels_Onboarding_PageOne(
          description:
              'Yulii is the first app that allows you to organize daily activities with your loved ones in a fun filled manner!\n\nWith a point-awarded task allocation system, you can motivate your family and friends to do tasks and reward them for successfully completing them.',
          title: 'Family activities made fun',
        ),
        pageTwo: AppLocalizations_Labels_Onboarding_PageTwo(
          description:
              'Activities are given as deals within a group of friends and / or family members.\n\nAny member of your group can give you deals and you can give them also.\n\nWith each deal a member who has been assigned a task earn points. Which will eventually lead to rewards.\n\nThe addition of photos / videos is also available for all content.',
          title: 'Get deals done',
        ),
        pageThree: AppLocalizations_Labels_Onboarding_PageThree(
          description:
              'With the Yulli app, the task / reward system can take many forms. This could be a member offering another member a specified reward for completing a specific task under easily defined conditions and timeframe (Pro giveaway) or\n\nA member offering another member a reward through a points earning system where the member has made deals and earned enough points for it (gift)\n\nA member can also get a mystery gift! as part of a task performance arrangement where the member would not know what the reward is until the task is successfully completed',
          title: 'Reward yourself and others',
        ),
        pageFour: AppLocalizations_Labels_Onboarding_PageFour(
          description:
              'With the chat built into the Yulli app, you can stay in touch with your friends, family and at the same time get information on specific deals and rewards without leaving the app!',
          title: 'Stay connected to your family',
        ),
        pageFive: AppLocalizations_Labels_Onboarding_PageFive(
          description:
              'There is a lot more to discover in the app. We\'ll let you take advantage of it, but if you have any questions, don\'t hesitate to consult our frequently asked questions (Q&A) to learn more about its functionalities and maybe discover some tips to stay at the top of the leaderboard!',
          title: 'And much more !',
        ),
      ),
    ),
    Locale.fromSubtags(languageCode: 'fr'): AppLocalization_Labels(
      dates: AppLocalizations_Labels_Dates(
        weekday: AppLocalizations_Labels_Dates_Weekday(
          monday: 'Lundi',
          tuesday: 'Mardi',
          wednesday: 'Mercredi',
          thursday: 'Jeudi',
          friday: 'Vendredi',
          saturday: 'Samedi',
          sunday: 'Dimanche',
        ),
        month: AppLocalizations_Labels_Dates_Month(
          january: 'Janvier',
          february: 'F??vrier',
          march: 'Mars',
          april: 'Avril',
          may: 'Mai',
          june: 'Juin',
          july: 'Juillet',
          august: 'A??ut',
          september: 'Septembre',
          october: 'Octobre',
          november: 'Novembre',
          december: 'D??cembre',
        ),
      ),
      screens: AppLocalizations_Labels_Screens(
        home: 'Accueil',
        deals: 'Deals',
        goals: 'R??compenses',
        profile: 'Moi',
        settings: 'R??glages',
        notifications: 'Notifications',
      ),
      richtext: AppLocalizations_Labels_Richtext(
        signUpCaption: ({tagOneOpen, tagOneClose, tagTwoOpen, tagTwoClose}) =>
            '''Inscris-toi ?? Yulii et d??couvre comment tu peux ${tagOneOpen}t???amuser${tagOneClose} en r??alisant des t??ches quotidiennes ${tagTwoOpen}en famille ou entre amis !${tagTwoClose}''',
      ),
      templated: AppLocalizations_Labels_Templated(
        hello: ({firstname}) => '''Salut, ${firstname}!''',
      ),
      labels: AppLocalizations_Labels_Labels(
        lastname: 'Nom',
        firstname: 'Pr??nom',
        email: 'Adresse e-mail',
        password: 'Mot de passe',
        dealName: 'Nom du deal',
        description: 'Description',
        code: 'Code',
        toSignIn: 'Se connecter',
        signIn: 'Connectez-vous',
        toSignUp: 'S\'inscrire',
        signUp: 'Inscrivez-vous',
        toSignOut: 'Se d??connecter',
        alreadyHaveAccount: 'J\'ai d??j?? un compte',
        forgottenPassword: 'Mot de passe oubli?? ?',
        submiting: 'Soumission...',
        retrievePassword: 'R??cup??rer le mot de passe',
        verifyCode: 'V??rifier le code',
        back: 'Retour',
        passwordConfirmation: 'Confirmation de mot passe',
        newPassord: 'Nouveau mot de passe',
        cancel: 'Annuler',
        createNewPassord: 'Cr??er un nouveau mot de passe',
        dontHaveAnAccount: 'Vous n\'avez pas de compte ?',
        clickOnVerificationLink:
            'Cliquez sur le lien de v??rification envoy?? ?? votre adresse e-mail. Une fois termin??, appuyez sur le bouton ci-dessous pour continuer.',
        sendPasswordReset:
            'Entrez votre adresse email. Nous vous enverrons un lien de r??initialisation de mot de passe si vous ??tes inscrit.',
        passwordResetEmailSent:
            'Email de r??initialisation de mot de passe envoy??. Consultez votre bo??te de reception.',
        backToLogin: 'Revenir ?? la connexion',
        loggedInAs: 'Connect??(e) en tant que',
        all: 'Tout',
        accountSettings: 'Param??tres du compte',
        about: '?? propos',
        aboutOf: ({name}) => '''?? propos de ${name}''',
        qa: 'FAQ',
        terms: 'Conditions g??n??rales',
        privacyPolicy: 'Politique de confidentialit??',
        myLastDeals: 'Mes derniers deals',
        myGoals: 'Mes r??compenses',
        myDeals: 'Mes deals',
        allGoals: 'Toutes les r??compenses',
        allDeals: 'Tous les deals',
        goalName: 'Nom de la r??compense',
        members: 'Membres',
        confirm: 'Confirmer',
        shootingTips:
            'Appuyez pour prendre une photo. Appuyez longuement pour enregistrer une vid??o.',
        languageName: 'Fran??ais',
        language: 'Langue',
        suggestTo: 'Suggerer ??',
        suggestedTo: 'Sugg??r?? ??',
        assignTo: 'Assigner ??',
        assignedTo: 'Assign?? ??',
        requiredPoints: 'Points requis',
        points: 'Points',
        nameOrEmail: 'Nom ou email',
        status: 'Statut',
        done: 'Valid??',
        declined: 'Refus??',
        pending: 'En attente',
        opened: '?? faire',
        mysteryGift: 'R??compense myst??re !',
        mysteryGiftQuestionMark: 'R??compense myst??re ?',
        date: 'Date',
        tutorial: 'Tutoriel',
        enterFriendEmail: 'Entrer l\'adresse e-mail de votre ami',
        relatedDeals: 'Deal(s) li??(s)',
        friends: 'Ami(e)s',
        myStats: 'Mes stats',
        pointsPlaceholder: ({points}) => '''${points} points''',
        reward: 'R??compense',
        rewardPro: 'R??compense Pro',
        deal: 'Deal',
        tasksAssignedTo: ({username}) => '''Deals assign??s ?? ${username}''',
        tasksSuggeredBy: ({username}) => '''Deals sugger??s par ${username}''',
        labelRequired: 'Requis',
        profilePicture: 'Photo de profil',
        deletePicture: 'Supprimer la photo',
        takePicture: 'Prendre une photo',
        takeVideo: 'Prendre une video',
        gallery: 'Gallerie',
        camera: 'Cam??ra',
        noDeal: 'Aucun deal',
        noReward: 'Aucune r??compense',
        dealCountPlaceholder: (condition, {count}) {
          if (condition == Plural.one) return '''${count} deal''';
          if (condition == Plural.zero) return '''${count} deal''';
          if (condition == Plural.multiple) return '''${count} deals''';
          throw Exception();
        },
        filter: 'Filtre',
        ongoingRewards: 'R??compenses en cours',
        claimedRewards: 'R??compenses r??clam??es',
        requiredPointsCount: 'Nombre de points requis',
        rewardDescription:
            'Le mode "r??compense simple " vous permet de proposer des cadeaux que vos amis / famille pourront d??bloquer s???ils ont assez de points cumul??s.',
        proRewardDescription:
            'Le mode " r??compense pro " vous permet de lier des deals qui devront ??tre accomplis afin de d??bloquer la r??compense.',
        myMessages: 'Mes messages',
        selectAFriend: 'S??lectionnez un ami',
        selectPhoto: 'S??lectionnez une photo',
        selectVideo: 'S??lectionnez une video',
        confirmMediaUpload: 'Confirmez-vous l\'envoi du fichier ?',
        confirmFriendDeletion:
            'Vous ??tes sur le point de supprimer un ami. Confirmez-vous ?',
        confirmation: 'Confirmation',
        newItem: 'Nouveau',
        claimedItem: 'Reclam??',
      ),
      hints: AppLocalizations_Labels_Hints(
        lastname: 'Votre nom de famille',
        firstname: 'Votre pr??nom',
        email: 'Votre adresse e-mail',
        password: 'Votre mot de passe',
        code: 'Entrez le code de v??rification',
        passwordConfirmation: 'Entrez la confirmation de mot de passe',
        newPassord: 'Entrez le nouveau mot de passe',
        typeAMessage: 'Tapez un message',
      ),
      notifications: AppLocalizations_Labels_Notifications(
        invitation: ({user}) => '''${user} vous a envoy?? une invitation''',
        invitationAccepted: ({user}) =>
            '''${user} a accept?? votre invitation.''',
        newMessage: ({user}) => '''${user} vous a envoy?? un nouveau message''',
        validationRequestDeal: ({name, title}) =>
            '''${name} demande la validation du deal : ${title}''',
        approvedDeal: ({name, title}) =>
            '''${name} a valid?? le deal : ${title}''',
        declinedDeal: ({name, title}) =>
            '''${name} a refus?? le deal : ${title}''',
        suggestedDeal: ({name, title}) =>
            '''${name} a sugg??r?? la r??compense ${title}''',
        assignedDeal: ({name, title}) =>
            '''${name} vous a attribu?? une r??compense ${title}''',
        assignedMysteryDeal: ({name}) =>
            '''${name} vous a attribu?? une r??compense myst??re''',
        newReward: ({goalName}) =>
            '''Vous avez une nouvelle r??compense : ${goalName}''',
        newDeal: ({taskName}) => '''Vous avez un nouveau deal : ${taskName}''',
        doneDeal: ({name, taskName}) =>
            '''${name} a fini la deal : ${taskName}''',
        claimReward: ({name, goalName}) =>
            '''${name} souhaite r??clamer une r??compense: ${goalName}''',
        acceptedSuggestedReward: ({goalName}) =>
            '''La r??compense sugg??r?? a ??t?? accept?? : ${goalName}''',
        declinedSuggestedReward: ({goalName}) =>
            '''La r??compense sugg??r?? a ??t?? refus?? : ${goalName}''',
      ),
      errors: AppLocalizations_Labels_Errors(
        validations: AppLocalizations_Labels_Errors_Validations(
          names: ({field}) =>
              '''${field} doit seulement contenir des lettres et des espaces entre les mots''',
          minimum: ({field, min}) =>
              '''${field} doit contenir au moins ${min} caract??res''',
          maximum: ({field, max}) =>
              '''${field} doit contenir ${max} caract??res maximum''',
          length: ({field, min, max}) =>
              '''${field} doit comprendre entre ${min} et ${max} caract??res''',
          invalidEmail: 'L\'adresse e-mail n\'est pas valide',
          alreadyInUseEmail: 'Cet adresse e-mail est d??j?? enregistr??e',
          notRegisteredEmail: 'Cet adresse e-mail n\'est pas enregistr??e',
          passwordLength: ({min}) =>
              '''Le mot de passe doit contenir au moins ${min} caract??res''',
          passwordRegex:
              'Le mot de passe doit contenir au moins 1 chiffre et 1 lettre',
          invalidCredentials: 'Identifiants invalides',
          disabledUser: 'D??sol??, votre compte a ??t?? r??voqu??',
          fieldRequired: ({field}) => '''${field} est obligatoire''',
          sameEmailThanYou: 'Cet e-mail est le m??me que le v??tre',
          alreadyFriend: 'Vous ??tes d??j?? ami avec cet utilisateur',
        ),
        forms: AppLocalizations_Labels_Errors_Forms(
          invalid: 'Formulaire non valide',
        ),
        exceptions: AppLocalizations_Labels_Errors_Exceptions(
          unexpected: 'Erreur innatendue',
          tooManyRequests: 'Trop de demandes. R??essayez plus tard',
          operationNotAllowed: 'Op??ration non autoris??e',
          networkConnectionFailed: 'La connexion r??seau a ??chou??',
        ),
      ),
      events: AppLocalizations_Labels_Events(
        loading: 'Chargement',
        loadingAlternative: 'Chargement...',
        submitting: 'Soumission',
        checking: 'V??rification...',
        submittingAlternative: 'Soumission...',
      ),
      actions: AppLocalizations_Labels_Actions(
        check: 'V??rifier',
        resendEmailVerification: 'Renvoyer la v??rification',
        ignore: 'Ignorer',
        accept: 'Accepter',
        addFriend: 'Ajouter un ami / famille',
        addDeal: 'Ajouter un deal',
        addGoal: 'Ajouter une r??compense',
        edit: 'Modifier',
        save: 'Enregistrer',
        signOut: 'Je me d??connecte',
        searchDeal: 'Rechercher un deal',
        searchGoal: 'Rechercher une r??compense',
        searchFriend: 'Rechercher un ami',
        sendInvitation: 'Envoyer l\'invitation',
        claimReward: 'R??clamer la r??compense',
        editReward: 'Modifier la r??compense',
        editTask: 'Modifier le deal',
        delete: 'Supprimer',
      ),
      notice: AppLocalizations_Labels_Notice(
        emailNotVerified: 'L\'adresse e-mail n\'est pas v??rifi??e',
        emailSent: 'E-mail envoy??',
        waitInSeconds: ({seconds}) =>
            '''Patientez ${seconds}s avant de recommencer''',
        beforeSignOut:
            'Vous ??tes sur le point de vous d??connecter. Confirmez-vous ?',
        dealsCompleted: 'deals finis',
      ),
      longText: AppLocalizations_Labels_LongText(
        about:
            'Yulii est la red??finition des d??fis mobiles pour famille et les amis.\n\nSur cet d\'application mobile, vous serez pr??sent?? a deux c??t??s, le r??mun??rateur et le joueur. En tant que r??mun??rateur, vous pouvez cr??er une ou plusieurs r??compenses pour le joueur, chacune contenant un certain nombre de points cr????s par vous m??me. Parall??lement ?? ces r??compenses, vous cr??ez ??galement des t??ches que le joueur doit accomplir pour obtenir ces r??compenses. Chaque t??che contenant ??galement un certain nombre de points cr????s par vous meme.\n\nEn tant que joueur, l\'r??compense est d\'accomplir autant de t??ches que possible afin d\'obtenir suffisamment de points pour obtenir l\'une de ces r??compenses ??tablies par le r??mun??rateur.\n\nVous pourrez ??galement consulter r??guli??rement votre compte afin de voir combien de points vous avez et combien il vous reste ?? en avoir pour obtenir l\'une de ces r??compenses.\n\nAu fur et ?? mesure que vous jouez, vous d??couvrirez diff??rents types d\'options telles que:\n\n- Le ??Timer?? o?? le r??mun??rateur peut fixer une limite de temps pour certaines t??ches (ou toutes) ?? accomplir.\n\n- Le ??Cadeau Myst??re?? o?? le r??mun??rateur offre au joueur une r??compense myst??re ?? condition de r??aliser des t??ches sp??cifiques afin de l\'obtenir.\n\n- Et l \'??Accord Trait???? o?? le joueur peut proposer la r??compense de ses r??ves au r??mun??rateur et se mettre d\'accord sur le nombre de points n??cessaires pour l\'obtenir.\n\n\nAvec toutes ces notions ?? l\'??cart, laissez le plaisir commencer!',
      ),
      notices: AppLocalizations_Labels_Notices(
        dealCreated: 'Deal cr???? !',
        goalCreated: 'R??compense cr????e !',
        invitationSent: 'Invitation envoy??e',
        mysteryGiftNoticeAtCreation:
            'Le titre de la r??compense sera cach?? jusqu???au moment o?? l???utilisateur peut d??bloquer la r??compense avec ses points.',
        mysteryProGiftNoticeAtCreation:
            'Le titre de la r??compense sera cach?? jusqu????? l???accomplissement de tous les deals li??s ?? cet objectif.',
        cannotSelectTaskBeforeMember:
            'Vous devez d\'abord selectionner un membre',
        noDataFound: 'Aucune donn??e trouv??e',
        claimSent: 'R??clamation envoy??e',
        alreadyClaimed: 'Vous avez d??j?? r??clam?? cette r??compense',
        notEnoughPoints:
            'Vous n\'avez pas assez de points pour r??clamer cette r??compense',
        editDone: 'Modifi?? avec succ??s',
        noNotification: 'Aucune notification',
        linkedRewardIsStillPending:
            'La r??compense li??e est encore en attente de validation',
        unsupportedLink: 'Type de lien non support??',
      ),
      onboarding: AppLocalizations_Labels_Onboarding(
        pageOne: AppLocalizations_Labels_Onboarding_PageOne(
          description:
              'Yulii est la premi??re application qui vous permet d???organiser des activit??s quotidiennes avec vos proches d\'une mani??re amusante!\n\nAvec un syst??me d\'attribution de points, vous pouvez motiver votre famille et vos amis ?? accomplir des t??ches et les r??compenser pour leur r??ussite.',
          title: 'Activit??s familiales rendues amusantes',
        ),
        pageTwo: AppLocalizations_Labels_Onboarding_PageTwo(
          description:
              'Les activit??s sont donn??es sous forme de deals au sein d\'un m??me groupe, amis ou famille.\n\nN\'importe quel membre de votre groupe peut vous proposer des deals et vous pouvez ??galement leur en donner !\n\nAvec chaque offre, un membre ?? qui une t??che a ??t?? assign??e gagne des points qui m??neront ??ventuellement ?? des r??compenses\n\nL\'ajout de photos / vid??os est ??galement disponible.\n',
          title: 'Completez toutes vos offres',
        ),
        pageThree: AppLocalizations_Labels_Onboarding_PageThree(
          description:
              'Avec l\'application Yulli, le syst??me de t??ches /r??compenses peut prendre plusieurs formes. Il peut s\'agir d\'un membre offrant ?? un autre membre une r??compense sp??cifi??e pour avoir accompli une t??che sp??cifique dans des conditions et un d??lai faciles ?? d??finir (cadeau Pro) ou\n\nUn membre offrant ?? un autre membre une r??compense gr??ce ?? un syst??me de gain de points o?? le membre a conclu des deals et a gagn?? suffisamment de points pour cela (cadeau)\n\nUn membre peut ??galement obtenir un cadeau myst??re !  dans le cadre d\'un arrangement d???ex??cution de t??ches dans lequel le membre ne saurait pas ce qu\'est la r??compense tant que la t??che n\'est pas accomplis avec succ??s',
          title: 'Recompensez-vous m??me et les autres aussi',
        ),
        pageFour: AppLocalizations_Labels_Onboarding_PageFour(
          description:
              'Avec le chat int??gr?? ?? l\'application Yulli, vous pouvez restez en contact avec vos amis, votre famille et en m??me temps, obtenir des informations sur des deals et des r??compenses sp??cifiques sans quitter l\'application !',
          title: 'Restez connect?? avec votre famille',
        ),
        pageFive: AppLocalizations_Labels_Onboarding_PageFive(
          description:
              'Il y a beaucoup plus ?? d??couvrir dans l\'application. Nous vous laissons de ce pas en profiter, mais si vous avez des questions, n???h??sitez pas a consulter notre foir aux questions (FAQ) pour en savoir plus sur ses fonctionnalit??s et peut-??tre d??couvrir quelques astuces pour rester en t??te du classement !',
          title: 'Et bien plus !',
        ),
      ),
    ),
  };

  final AppLocalization_Labels labels;

  static AppLocalization_Labels of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization)?.labels;
}

enum Plural {
  one,
  zero,
  multiple,
}

class AppLocalizations_Labels_Dates_Weekday {
  const AppLocalizations_Labels_Dates_Weekday(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  final String monday;

  final String tuesday;

  final String wednesday;

  final String thursday;

  final String friday;

  final String saturday;

  final String sunday;

  String getByKey(String key) {
    switch (key) {
      case 'monday':
        return monday;
      case 'tuesday':
        return tuesday;
      case 'wednesday':
        return wednesday;
      case 'thursday':
        return thursday;
      case 'friday':
        return friday;
      case 'saturday':
        return saturday;
      case 'sunday':
        return sunday;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Dates_Month {
  const AppLocalizations_Labels_Dates_Month(
      {this.january,
      this.february,
      this.march,
      this.april,
      this.may,
      this.june,
      this.july,
      this.august,
      this.september,
      this.october,
      this.november,
      this.december});

  final String january;

  final String february;

  final String march;

  final String april;

  final String may;

  final String june;

  final String july;

  final String august;

  final String september;

  final String october;

  final String november;

  final String december;

  String getByKey(String key) {
    switch (key) {
      case 'january':
        return january;
      case 'february':
        return february;
      case 'march':
        return march;
      case 'april':
        return april;
      case 'may':
        return may;
      case 'june':
        return june;
      case 'july':
        return july;
      case 'august':
        return august;
      case 'september':
        return september;
      case 'october':
        return october;
      case 'november':
        return november;
      case 'december':
        return december;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Dates {
  const AppLocalizations_Labels_Dates({this.weekday, this.month});

  final AppLocalizations_Labels_Dates_Weekday weekday;

  final AppLocalizations_Labels_Dates_Month month;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Screens {
  const AppLocalizations_Labels_Screens(
      {this.home,
      this.deals,
      this.goals,
      this.profile,
      this.settings,
      this.notifications});

  final String home;

  final String deals;

  final String goals;

  final String profile;

  final String settings;

  final String notifications;

  String getByKey(String key) {
    switch (key) {
      case 'home':
        return home;
      case 'deals':
        return deals;
      case 'goals':
        return goals;
      case 'profile':
        return profile;
      case 'settings':
        return settings;
      case 'notifications':
        return notifications;
      default:
        return '';
    }
  }
}

typedef AppLocalizations_Labels_Richtext_signUpCaption = String Function(
    {@required String tagOneOpen,
    @required String tagOneClose,
    @required String tagTwoOpen,
    @required String tagTwoClose});

class AppLocalizations_Labels_Richtext {
  const AppLocalizations_Labels_Richtext(
      {AppLocalizations_Labels_Richtext_signUpCaption signUpCaption})
      : _signUpCaption = signUpCaption;

  final AppLocalizations_Labels_Richtext_signUpCaption _signUpCaption;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String signUpCaption(
          {@required String tagOneOpen,
          @required String tagOneClose,
          @required String tagTwoOpen,
          @required String tagTwoClose}) =>
      _signUpCaption(
        tagOneOpen: tagOneOpen,
        tagOneClose: tagOneClose,
        tagTwoOpen: tagTwoOpen,
        tagTwoClose: tagTwoClose,
      );
}

typedef AppLocalizations_Labels_Templated_hello = String Function(
    {@required String firstname});

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_hello hello})
      : _hello = hello;

  final AppLocalizations_Labels_Templated_hello _hello;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String hello({@required String firstname}) => _hello(
        firstname: firstname,
      );
}

typedef AppLocalizations_Labels_Labels_aboutOf = String Function(
    {@required String name});
typedef AppLocalizations_Labels_Labels_pointsPlaceholder = String Function(
    {@required String points});
typedef AppLocalizations_Labels_Labels_tasksAssignedTo = String Function(
    {@required String username});
typedef AppLocalizations_Labels_Labels_tasksSuggeredBy = String Function(
    {@required String username});
typedef AppLocalizations_Labels_Labels_dealCountPlaceholder = String
    Function(Plural condition, {@required String count});

class AppLocalizations_Labels_Labels {
  const AppLocalizations_Labels_Labels(
      {this.lastname,
      this.firstname,
      this.email,
      this.password,
      this.dealName,
      this.description,
      this.code,
      this.toSignIn,
      this.signIn,
      this.toSignUp,
      this.signUp,
      this.toSignOut,
      this.alreadyHaveAccount,
      this.forgottenPassword,
      this.submiting,
      this.retrievePassword,
      this.verifyCode,
      this.back,
      this.passwordConfirmation,
      this.newPassord,
      this.cancel,
      this.createNewPassord,
      this.dontHaveAnAccount,
      this.clickOnVerificationLink,
      this.sendPasswordReset,
      this.passwordResetEmailSent,
      this.backToLogin,
      this.loggedInAs,
      this.all,
      this.accountSettings,
      this.about,
      AppLocalizations_Labels_Labels_aboutOf aboutOf,
      this.qa,
      this.terms,
      this.privacyPolicy,
      this.myLastDeals,
      this.myGoals,
      this.myDeals,
      this.allGoals,
      this.allDeals,
      this.goalName,
      this.members,
      this.confirm,
      this.shootingTips,
      this.languageName,
      this.language,
      this.suggestTo,
      this.suggestedTo,
      this.assignTo,
      this.assignedTo,
      this.requiredPoints,
      this.points,
      this.nameOrEmail,
      this.status,
      this.done,
      this.declined,
      this.pending,
      this.opened,
      this.mysteryGift,
      this.mysteryGiftQuestionMark,
      this.date,
      this.tutorial,
      this.enterFriendEmail,
      this.relatedDeals,
      this.friends,
      this.myStats,
      AppLocalizations_Labels_Labels_pointsPlaceholder pointsPlaceholder,
      this.reward,
      this.rewardPro,
      this.deal,
      AppLocalizations_Labels_Labels_tasksAssignedTo tasksAssignedTo,
      AppLocalizations_Labels_Labels_tasksSuggeredBy tasksSuggeredBy,
      this.labelRequired,
      this.profilePicture,
      this.deletePicture,
      this.takePicture,
      this.takeVideo,
      this.gallery,
      this.camera,
      this.noDeal,
      this.noReward,
      AppLocalizations_Labels_Labels_dealCountPlaceholder dealCountPlaceholder,
      this.filter,
      this.ongoingRewards,
      this.claimedRewards,
      this.requiredPointsCount,
      this.rewardDescription,
      this.proRewardDescription,
      this.myMessages,
      this.selectAFriend,
      this.selectPhoto,
      this.selectVideo,
      this.confirmMediaUpload,
      this.confirmFriendDeletion,
      this.confirmation,
      this.newItem,
      this.claimedItem})
      : _aboutOf = aboutOf,
        _pointsPlaceholder = pointsPlaceholder,
        _tasksAssignedTo = tasksAssignedTo,
        _tasksSuggeredBy = tasksSuggeredBy,
        _dealCountPlaceholder = dealCountPlaceholder;

  final String lastname;

  final String firstname;

  final String email;

  final String password;

  final String dealName;

  final String description;

  final String code;

  final String toSignIn;

  final String signIn;

  final String toSignUp;

  final String signUp;

  final String toSignOut;

  final String alreadyHaveAccount;

  final String forgottenPassword;

  final String submiting;

  final String retrievePassword;

  final String verifyCode;

  final String back;

  final String passwordConfirmation;

  final String newPassord;

  final String cancel;

  final String createNewPassord;

  final String dontHaveAnAccount;

  final String clickOnVerificationLink;

  final String sendPasswordReset;

  final String passwordResetEmailSent;

  final String backToLogin;

  final String loggedInAs;

  final String all;

  final String accountSettings;

  final String about;

  final AppLocalizations_Labels_Labels_aboutOf _aboutOf;

  final String qa;

  final String terms;

  final String privacyPolicy;

  final String myLastDeals;

  final String myGoals;

  final String myDeals;

  final String allGoals;

  final String allDeals;

  final String goalName;

  final String members;

  final String confirm;

  final String shootingTips;

  final String languageName;

  final String language;

  final String suggestTo;

  final String suggestedTo;

  final String assignTo;

  final String assignedTo;

  final String requiredPoints;

  final String points;

  final String nameOrEmail;

  final String status;

  final String done;

  final String declined;

  final String pending;

  final String opened;

  final String mysteryGift;

  final String mysteryGiftQuestionMark;

  final String date;

  final String tutorial;

  final String enterFriendEmail;

  final String relatedDeals;

  final String friends;

  final String myStats;

  final AppLocalizations_Labels_Labels_pointsPlaceholder _pointsPlaceholder;

  final String reward;

  final String rewardPro;

  final String deal;

  final AppLocalizations_Labels_Labels_tasksAssignedTo _tasksAssignedTo;

  final AppLocalizations_Labels_Labels_tasksSuggeredBy _tasksSuggeredBy;

  final String labelRequired;

  final String profilePicture;

  final String deletePicture;

  final String takePicture;

  final String takeVideo;

  final String gallery;

  final String camera;

  final String noDeal;

  final String noReward;

  final AppLocalizations_Labels_Labels_dealCountPlaceholder
      _dealCountPlaceholder;

  final String filter;

  final String ongoingRewards;

  final String claimedRewards;

  final String requiredPointsCount;

  final String rewardDescription;

  final String proRewardDescription;

  final String myMessages;

  final String selectAFriend;

  final String selectPhoto;

  final String selectVideo;

  final String confirmMediaUpload;

  final String confirmFriendDeletion;

  final String confirmation;

  final String newItem;

  final String claimedItem;

  String getByKey(String key) {
    switch (key) {
      case 'lastname':
        return lastname;
      case 'firstname':
        return firstname;
      case 'email':
        return email;
      case 'password':
        return password;
      case 'dealName':
        return dealName;
      case 'description':
        return description;
      case 'code':
        return code;
      case 'toSignIn':
        return toSignIn;
      case 'signIn':
        return signIn;
      case 'toSignUp':
        return toSignUp;
      case 'signUp':
        return signUp;
      case 'toSignOut':
        return toSignOut;
      case 'alreadyHaveAccount':
        return alreadyHaveAccount;
      case 'forgottenPassword':
        return forgottenPassword;
      case 'submiting':
        return submiting;
      case 'retrievePassword':
        return retrievePassword;
      case 'verifyCode':
        return verifyCode;
      case 'back':
        return back;
      case 'passwordConfirmation':
        return passwordConfirmation;
      case 'newPassord':
        return newPassord;
      case 'cancel':
        return cancel;
      case 'createNewPassord':
        return createNewPassord;
      case 'dontHaveAnAccount':
        return dontHaveAnAccount;
      case 'clickOnVerificationLink':
        return clickOnVerificationLink;
      case 'sendPasswordReset':
        return sendPasswordReset;
      case 'passwordResetEmailSent':
        return passwordResetEmailSent;
      case 'backToLogin':
        return backToLogin;
      case 'loggedInAs':
        return loggedInAs;
      case 'all':
        return all;
      case 'accountSettings':
        return accountSettings;
      case 'about':
        return about;
      case 'qa':
        return qa;
      case 'terms':
        return terms;
      case 'privacyPolicy':
        return privacyPolicy;
      case 'myLastDeals':
        return myLastDeals;
      case 'myGoals':
        return myGoals;
      case 'myDeals':
        return myDeals;
      case 'allGoals':
        return allGoals;
      case 'allDeals':
        return allDeals;
      case 'goalName':
        return goalName;
      case 'members':
        return members;
      case 'confirm':
        return confirm;
      case 'shootingTips':
        return shootingTips;
      case 'languageName':
        return languageName;
      case 'language':
        return language;
      case 'suggestTo':
        return suggestTo;
      case 'suggestedTo':
        return suggestedTo;
      case 'assignTo':
        return assignTo;
      case 'assignedTo':
        return assignedTo;
      case 'requiredPoints':
        return requiredPoints;
      case 'points':
        return points;
      case 'nameOrEmail':
        return nameOrEmail;
      case 'status':
        return status;
      case 'done':
        return done;
      case 'declined':
        return declined;
      case 'pending':
        return pending;
      case 'opened':
        return opened;
      case 'mysteryGift':
        return mysteryGift;
      case 'mysteryGiftQuestionMark':
        return mysteryGiftQuestionMark;
      case 'date':
        return date;
      case 'tutorial':
        return tutorial;
      case 'enterFriendEmail':
        return enterFriendEmail;
      case 'relatedDeals':
        return relatedDeals;
      case 'friends':
        return friends;
      case 'myStats':
        return myStats;
      case 'reward':
        return reward;
      case 'rewardPro':
        return rewardPro;
      case 'deal':
        return deal;
      case 'labelRequired':
        return labelRequired;
      case 'profilePicture':
        return profilePicture;
      case 'deletePicture':
        return deletePicture;
      case 'takePicture':
        return takePicture;
      case 'takeVideo':
        return takeVideo;
      case 'gallery':
        return gallery;
      case 'camera':
        return camera;
      case 'noDeal':
        return noDeal;
      case 'noReward':
        return noReward;
      case 'filter':
        return filter;
      case 'ongoingRewards':
        return ongoingRewards;
      case 'claimedRewards':
        return claimedRewards;
      case 'requiredPointsCount':
        return requiredPointsCount;
      case 'rewardDescription':
        return rewardDescription;
      case 'proRewardDescription':
        return proRewardDescription;
      case 'myMessages':
        return myMessages;
      case 'selectAFriend':
        return selectAFriend;
      case 'selectPhoto':
        return selectPhoto;
      case 'selectVideo':
        return selectVideo;
      case 'confirmMediaUpload':
        return confirmMediaUpload;
      case 'confirmFriendDeletion':
        return confirmFriendDeletion;
      case 'confirmation':
        return confirmation;
      case 'newItem':
        return newItem;
      case 'claimedItem':
        return claimedItem;
      default:
        return '';
    }
  }

  String aboutOf({@required String name}) => _aboutOf(
        name: name,
      );
  String pointsPlaceholder({@required String points}) => _pointsPlaceholder(
        points: points,
      );
  String tasksAssignedTo({@required String username}) => _tasksAssignedTo(
        username: username,
      );
  String tasksSuggeredBy({@required String username}) => _tasksSuggeredBy(
        username: username,
      );
  String dealCountPlaceholder(Plural condition, {@required String count}) =>
      _dealCountPlaceholder(
        condition,
        count: count,
      );
}

class AppLocalizations_Labels_Hints {
  const AppLocalizations_Labels_Hints(
      {this.lastname,
      this.firstname,
      this.email,
      this.password,
      this.code,
      this.passwordConfirmation,
      this.newPassord,
      this.typeAMessage});

  final String lastname;

  final String firstname;

  final String email;

  final String password;

  final String code;

  final String passwordConfirmation;

  final String newPassord;

  final String typeAMessage;

  String getByKey(String key) {
    switch (key) {
      case 'lastname':
        return lastname;
      case 'firstname':
        return firstname;
      case 'email':
        return email;
      case 'password':
        return password;
      case 'code':
        return code;
      case 'passwordConfirmation':
        return passwordConfirmation;
      case 'newPassord':
        return newPassord;
      case 'typeAMessage':
        return typeAMessage;
      default:
        return '';
    }
  }
}

typedef AppLocalizations_Labels_Notifications_invitation = String Function(
    {@required String user});
typedef AppLocalizations_Labels_Notifications_invitationAccepted = String
    Function({@required String user});
typedef AppLocalizations_Labels_Notifications_newMessage = String Function(
    {@required String user});
typedef AppLocalizations_Labels_Notifications_validationRequestDeal = String
    Function({@required String name, @required String title});
typedef AppLocalizations_Labels_Notifications_approvedDeal = String Function(
    {@required String name, @required String title});
typedef AppLocalizations_Labels_Notifications_declinedDeal = String Function(
    {@required String name, @required String title});
typedef AppLocalizations_Labels_Notifications_suggestedDeal = String Function(
    {@required String name, @required String title});
typedef AppLocalizations_Labels_Notifications_assignedDeal = String Function(
    {@required String name, @required String title});
typedef AppLocalizations_Labels_Notifications_assignedMysteryDeal = String
    Function({@required String name});
typedef AppLocalizations_Labels_Notifications_newReward = String Function(
    {@required String goalName});
typedef AppLocalizations_Labels_Notifications_newDeal = String Function(
    {@required String taskName});
typedef AppLocalizations_Labels_Notifications_doneDeal = String Function(
    {@required String name, @required String taskName});
typedef AppLocalizations_Labels_Notifications_claimReward = String Function(
    {@required String name, @required String goalName});
typedef AppLocalizations_Labels_Notifications_acceptedSuggestedReward = String
    Function({@required String goalName});
typedef AppLocalizations_Labels_Notifications_declinedSuggestedReward = String
    Function({@required String goalName});

class AppLocalizations_Labels_Notifications {
  const AppLocalizations_Labels_Notifications(
      {AppLocalizations_Labels_Notifications_invitation invitation,
      AppLocalizations_Labels_Notifications_invitationAccepted
          invitationAccepted,
      AppLocalizations_Labels_Notifications_newMessage newMessage,
      AppLocalizations_Labels_Notifications_validationRequestDeal
          validationRequestDeal,
      AppLocalizations_Labels_Notifications_approvedDeal approvedDeal,
      AppLocalizations_Labels_Notifications_declinedDeal declinedDeal,
      AppLocalizations_Labels_Notifications_suggestedDeal suggestedDeal,
      AppLocalizations_Labels_Notifications_assignedDeal assignedDeal,
      AppLocalizations_Labels_Notifications_assignedMysteryDeal
          assignedMysteryDeal,
      AppLocalizations_Labels_Notifications_newReward newReward,
      AppLocalizations_Labels_Notifications_newDeal newDeal,
      AppLocalizations_Labels_Notifications_doneDeal doneDeal,
      AppLocalizations_Labels_Notifications_claimReward claimReward,
      AppLocalizations_Labels_Notifications_acceptedSuggestedReward
          acceptedSuggestedReward,
      AppLocalizations_Labels_Notifications_declinedSuggestedReward
          declinedSuggestedReward})
      : _invitation = invitation,
        _invitationAccepted = invitationAccepted,
        _newMessage = newMessage,
        _validationRequestDeal = validationRequestDeal,
        _approvedDeal = approvedDeal,
        _declinedDeal = declinedDeal,
        _suggestedDeal = suggestedDeal,
        _assignedDeal = assignedDeal,
        _assignedMysteryDeal = assignedMysteryDeal,
        _newReward = newReward,
        _newDeal = newDeal,
        _doneDeal = doneDeal,
        _claimReward = claimReward,
        _acceptedSuggestedReward = acceptedSuggestedReward,
        _declinedSuggestedReward = declinedSuggestedReward;

  final AppLocalizations_Labels_Notifications_invitation _invitation;

  final AppLocalizations_Labels_Notifications_invitationAccepted
      _invitationAccepted;

  final AppLocalizations_Labels_Notifications_newMessage _newMessage;

  final AppLocalizations_Labels_Notifications_validationRequestDeal
      _validationRequestDeal;

  final AppLocalizations_Labels_Notifications_approvedDeal _approvedDeal;

  final AppLocalizations_Labels_Notifications_declinedDeal _declinedDeal;

  final AppLocalizations_Labels_Notifications_suggestedDeal _suggestedDeal;

  final AppLocalizations_Labels_Notifications_assignedDeal _assignedDeal;

  final AppLocalizations_Labels_Notifications_assignedMysteryDeal
      _assignedMysteryDeal;

  final AppLocalizations_Labels_Notifications_newReward _newReward;

  final AppLocalizations_Labels_Notifications_newDeal _newDeal;

  final AppLocalizations_Labels_Notifications_doneDeal _doneDeal;

  final AppLocalizations_Labels_Notifications_claimReward _claimReward;

  final AppLocalizations_Labels_Notifications_acceptedSuggestedReward
      _acceptedSuggestedReward;

  final AppLocalizations_Labels_Notifications_declinedSuggestedReward
      _declinedSuggestedReward;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }

  String invitation({@required String user}) => _invitation(
        user: user,
      );
  String invitationAccepted({@required String user}) => _invitationAccepted(
        user: user,
      );
  String newMessage({@required String user}) => _newMessage(
        user: user,
      );
  String validationRequestDeal(
          {@required String name, @required String title}) =>
      _validationRequestDeal(
        name: name,
        title: title,
      );
  String approvedDeal({@required String name, @required String title}) =>
      _approvedDeal(
        name: name,
        title: title,
      );
  String declinedDeal({@required String name, @required String title}) =>
      _declinedDeal(
        name: name,
        title: title,
      );
  String suggestedDeal({@required String name, @required String title}) =>
      _suggestedDeal(
        name: name,
        title: title,
      );
  String assignedDeal({@required String name, @required String title}) =>
      _assignedDeal(
        name: name,
        title: title,
      );
  String assignedMysteryDeal({@required String name}) => _assignedMysteryDeal(
        name: name,
      );
  String newReward({@required String goalName}) => _newReward(
        goalName: goalName,
      );
  String newDeal({@required String taskName}) => _newDeal(
        taskName: taskName,
      );
  String doneDeal({@required String name, @required String taskName}) =>
      _doneDeal(
        name: name,
        taskName: taskName,
      );
  String claimReward({@required String name, @required String goalName}) =>
      _claimReward(
        name: name,
        goalName: goalName,
      );
  String acceptedSuggestedReward({@required String goalName}) =>
      _acceptedSuggestedReward(
        goalName: goalName,
      );
  String declinedSuggestedReward({@required String goalName}) =>
      _declinedSuggestedReward(
        goalName: goalName,
      );
}

typedef AppLocalizations_Labels_Errors_Validations_names = String Function(
    {@required String field});
typedef AppLocalizations_Labels_Errors_Validations_minimum = String Function(
    {@required String field, @required String min});
typedef AppLocalizations_Labels_Errors_Validations_maximum = String Function(
    {@required String field, @required String max});
typedef AppLocalizations_Labels_Errors_Validations_length = String Function(
    {@required String field, @required String min, @required String max});
typedef AppLocalizations_Labels_Errors_Validations_passwordLength = String
    Function({@required String min});
typedef AppLocalizations_Labels_Errors_Validations_fieldRequired = String
    Function({@required String field});

class AppLocalizations_Labels_Errors_Validations {
  const AppLocalizations_Labels_Errors_Validations(
      {AppLocalizations_Labels_Errors_Validations_names names,
      AppLocalizations_Labels_Errors_Validations_minimum minimum,
      AppLocalizations_Labels_Errors_Validations_maximum maximum,
      AppLocalizations_Labels_Errors_Validations_length length,
      this.invalidEmail,
      this.alreadyInUseEmail,
      this.notRegisteredEmail,
      AppLocalizations_Labels_Errors_Validations_passwordLength passwordLength,
      this.passwordRegex,
      this.invalidCredentials,
      this.disabledUser,
      AppLocalizations_Labels_Errors_Validations_fieldRequired fieldRequired,
      this.sameEmailThanYou,
      this.alreadyFriend})
      : _names = names,
        _minimum = minimum,
        _maximum = maximum,
        _length = length,
        _passwordLength = passwordLength,
        _fieldRequired = fieldRequired;

  final AppLocalizations_Labels_Errors_Validations_names _names;

  final AppLocalizations_Labels_Errors_Validations_minimum _minimum;

  final AppLocalizations_Labels_Errors_Validations_maximum _maximum;

  final AppLocalizations_Labels_Errors_Validations_length _length;

  final String invalidEmail;

  final String alreadyInUseEmail;

  final String notRegisteredEmail;

  final AppLocalizations_Labels_Errors_Validations_passwordLength
      _passwordLength;

  final String passwordRegex;

  final String invalidCredentials;

  final String disabledUser;

  final AppLocalizations_Labels_Errors_Validations_fieldRequired _fieldRequired;

  final String sameEmailThanYou;

  final String alreadyFriend;

  String getByKey(String key) {
    switch (key) {
      case 'invalidEmail':
        return invalidEmail;
      case 'alreadyInUseEmail':
        return alreadyInUseEmail;
      case 'notRegisteredEmail':
        return notRegisteredEmail;
      case 'passwordRegex':
        return passwordRegex;
      case 'invalidCredentials':
        return invalidCredentials;
      case 'disabledUser':
        return disabledUser;
      case 'sameEmailThanYou':
        return sameEmailThanYou;
      case 'alreadyFriend':
        return alreadyFriend;
      default:
        return '';
    }
  }

  String names({@required String field}) => _names(
        field: field,
      );
  String minimum({@required String field, @required String min}) => _minimum(
        field: field,
        min: min,
      );
  String maximum({@required String field, @required String max}) => _maximum(
        field: field,
        max: max,
      );
  String length(
          {@required String field,
          @required String min,
          @required String max}) =>
      _length(
        field: field,
        min: min,
        max: max,
      );
  String passwordLength({@required String min}) => _passwordLength(
        min: min,
      );
  String fieldRequired({@required String field}) => _fieldRequired(
        field: field,
      );
}

class AppLocalizations_Labels_Errors_Forms {
  const AppLocalizations_Labels_Errors_Forms({this.invalid});

  final String invalid;

  String getByKey(String key) {
    switch (key) {
      case 'invalid':
        return invalid;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Errors_Exceptions {
  const AppLocalizations_Labels_Errors_Exceptions(
      {this.unexpected,
      this.tooManyRequests,
      this.operationNotAllowed,
      this.networkConnectionFailed});

  final String unexpected;

  final String tooManyRequests;

  final String operationNotAllowed;

  final String networkConnectionFailed;

  String getByKey(String key) {
    switch (key) {
      case 'unexpected':
        return unexpected;
      case 'tooManyRequests':
        return tooManyRequests;
      case 'operationNotAllowed':
        return operationNotAllowed;
      case 'networkConnectionFailed':
        return networkConnectionFailed;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Errors {
  const AppLocalizations_Labels_Errors(
      {this.validations, this.forms, this.exceptions});

  final AppLocalizations_Labels_Errors_Validations validations;

  final AppLocalizations_Labels_Errors_Forms forms;

  final AppLocalizations_Labels_Errors_Exceptions exceptions;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Events {
  const AppLocalizations_Labels_Events(
      {this.loading,
      this.loadingAlternative,
      this.submitting,
      this.checking,
      this.submittingAlternative});

  final String loading;

  final String loadingAlternative;

  final String submitting;

  final String checking;

  final String submittingAlternative;

  String getByKey(String key) {
    switch (key) {
      case 'loading':
        return loading;
      case 'loadingAlternative':
        return loadingAlternative;
      case 'submitting':
        return submitting;
      case 'checking':
        return checking;
      case 'submittingAlternative':
        return submittingAlternative;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Actions {
  const AppLocalizations_Labels_Actions(
      {this.check,
      this.resendEmailVerification,
      this.ignore,
      this.accept,
      this.addFriend,
      this.addDeal,
      this.addGoal,
      this.edit,
      this.save,
      this.signOut,
      this.searchDeal,
      this.searchGoal,
      this.searchFriend,
      this.sendInvitation,
      this.claimReward,
      this.editReward,
      this.editTask,
      this.delete});

  final String check;

  final String resendEmailVerification;

  final String ignore;

  final String accept;

  final String addFriend;

  final String addDeal;

  final String addGoal;

  final String edit;

  final String save;

  final String signOut;

  final String searchDeal;

  final String searchGoal;

  final String searchFriend;

  final String sendInvitation;

  final String claimReward;

  final String editReward;

  final String editTask;

  final String delete;

  String getByKey(String key) {
    switch (key) {
      case 'check':
        return check;
      case 'resendEmailVerification':
        return resendEmailVerification;
      case 'ignore':
        return ignore;
      case 'accept':
        return accept;
      case 'addFriend':
        return addFriend;
      case 'addDeal':
        return addDeal;
      case 'addGoal':
        return addGoal;
      case 'edit':
        return edit;
      case 'save':
        return save;
      case 'signOut':
        return signOut;
      case 'searchDeal':
        return searchDeal;
      case 'searchGoal':
        return searchGoal;
      case 'searchFriend':
        return searchFriend;
      case 'sendInvitation':
        return sendInvitation;
      case 'claimReward':
        return claimReward;
      case 'editReward':
        return editReward;
      case 'editTask':
        return editTask;
      case 'delete':
        return delete;
      default:
        return '';
    }
  }
}

typedef AppLocalizations_Labels_Notice_waitInSeconds = String Function(
    {@required String seconds});

class AppLocalizations_Labels_Notice {
  const AppLocalizations_Labels_Notice(
      {this.emailNotVerified,
      this.emailSent,
      AppLocalizations_Labels_Notice_waitInSeconds waitInSeconds,
      this.beforeSignOut,
      this.dealsCompleted})
      : _waitInSeconds = waitInSeconds;

  final String emailNotVerified;

  final String emailSent;

  final AppLocalizations_Labels_Notice_waitInSeconds _waitInSeconds;

  final String beforeSignOut;

  final String dealsCompleted;

  String getByKey(String key) {
    switch (key) {
      case 'emailNotVerified':
        return emailNotVerified;
      case 'emailSent':
        return emailSent;
      case 'beforeSignOut':
        return beforeSignOut;
      case 'dealsCompleted':
        return dealsCompleted;
      default:
        return '';
    }
  }

  String waitInSeconds({@required String seconds}) => _waitInSeconds(
        seconds: seconds,
      );
}

class AppLocalizations_Labels_LongText {
  const AppLocalizations_Labels_LongText({this.about});

  final String about;

  String getByKey(String key) {
    switch (key) {
      case 'about':
        return about;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Notices {
  const AppLocalizations_Labels_Notices(
      {this.dealCreated,
      this.goalCreated,
      this.invitationSent,
      this.mysteryGiftNoticeAtCreation,
      this.mysteryProGiftNoticeAtCreation,
      this.cannotSelectTaskBeforeMember,
      this.noDataFound,
      this.claimSent,
      this.alreadyClaimed,
      this.notEnoughPoints,
      this.editDone,
      this.noNotification,
      this.linkedRewardIsStillPending,
      this.unsupportedLink});

  final String dealCreated;

  final String goalCreated;

  final String invitationSent;

  final String mysteryGiftNoticeAtCreation;

  final String mysteryProGiftNoticeAtCreation;

  final String cannotSelectTaskBeforeMember;

  final String noDataFound;

  final String claimSent;

  final String alreadyClaimed;

  final String notEnoughPoints;

  final String editDone;

  final String noNotification;

  final String linkedRewardIsStillPending;

  final String unsupportedLink;

  String getByKey(String key) {
    switch (key) {
      case 'dealCreated':
        return dealCreated;
      case 'goalCreated':
        return goalCreated;
      case 'invitationSent':
        return invitationSent;
      case 'mysteryGiftNoticeAtCreation':
        return mysteryGiftNoticeAtCreation;
      case 'mysteryProGiftNoticeAtCreation':
        return mysteryProGiftNoticeAtCreation;
      case 'cannotSelectTaskBeforeMember':
        return cannotSelectTaskBeforeMember;
      case 'noDataFound':
        return noDataFound;
      case 'claimSent':
        return claimSent;
      case 'alreadyClaimed':
        return alreadyClaimed;
      case 'notEnoughPoints':
        return notEnoughPoints;
      case 'editDone':
        return editDone;
      case 'noNotification':
        return noNotification;
      case 'linkedRewardIsStillPending':
        return linkedRewardIsStillPending;
      case 'unsupportedLink':
        return unsupportedLink;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding_PageOne {
  const AppLocalizations_Labels_Onboarding_PageOne(
      {this.description, this.title});

  final String description;

  final String title;

  String getByKey(String key) {
    switch (key) {
      case 'description':
        return description;
      case 'title':
        return title;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding_PageTwo {
  const AppLocalizations_Labels_Onboarding_PageTwo(
      {this.description, this.title});

  final String description;

  final String title;

  String getByKey(String key) {
    switch (key) {
      case 'description':
        return description;
      case 'title':
        return title;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding_PageThree {
  const AppLocalizations_Labels_Onboarding_PageThree(
      {this.description, this.title});

  final String description;

  final String title;

  String getByKey(String key) {
    switch (key) {
      case 'description':
        return description;
      case 'title':
        return title;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding_PageFour {
  const AppLocalizations_Labels_Onboarding_PageFour(
      {this.description, this.title});

  final String description;

  final String title;

  String getByKey(String key) {
    switch (key) {
      case 'description':
        return description;
      case 'title':
        return title;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding_PageFive {
  const AppLocalizations_Labels_Onboarding_PageFive(
      {this.description, this.title});

  final String description;

  final String title;

  String getByKey(String key) {
    switch (key) {
      case 'description':
        return description;
      case 'title':
        return title;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Onboarding {
  const AppLocalizations_Labels_Onboarding(
      {this.pageOne,
      this.pageTwo,
      this.pageThree,
      this.pageFour,
      this.pageFive});

  final AppLocalizations_Labels_Onboarding_PageOne pageOne;

  final AppLocalizations_Labels_Onboarding_PageTwo pageTwo;

  final AppLocalizations_Labels_Onboarding_PageThree pageThree;

  final AppLocalizations_Labels_Onboarding_PageFour pageFour;

  final AppLocalizations_Labels_Onboarding_PageFive pageFive;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}

class AppLocalization_Labels {
  const AppLocalization_Labels(
      {this.dates,
      this.screens,
      this.richtext,
      this.templated,
      this.labels,
      this.hints,
      this.notifications,
      this.errors,
      this.events,
      this.actions,
      this.notice,
      this.longText,
      this.notices,
      this.onboarding});

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Screens screens;

  final AppLocalizations_Labels_Richtext richtext;

  final AppLocalizations_Labels_Templated templated;

  final AppLocalizations_Labels_Labels labels;

  final AppLocalizations_Labels_Hints hints;

  final AppLocalizations_Labels_Notifications notifications;

  final AppLocalizations_Labels_Errors errors;

  final AppLocalizations_Labels_Events events;

  final AppLocalizations_Labels_Actions actions;

  final AppLocalizations_Labels_Notice notice;

  final AppLocalizations_Labels_LongText longText;

  final AppLocalizations_Labels_Notices notices;

  final AppLocalizations_Labels_Onboarding onboarding;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}
