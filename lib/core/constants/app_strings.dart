import 'package:skill_bridge_mobile/features/profile/domain/entities/settings_content_entity.dart';

import '../../features/onboarding/domain/entities/subjects_entity.dart';

const List<SubjectsEntity> naturalSubjects = [
  SubjectsEntity(image: "assets/images/Chemistry.png", title: 'Chemistry'),
  SubjectsEntity(image: "assets/images/Biology.png", title: 'Biology'),
  SubjectsEntity(image: "assets/images/maths.png", title: 'Mathematics'),
  SubjectsEntity(image: "assets/images/Physics.png", title: 'physics'),
  SubjectsEntity(image: "assets/images/SAT.png", title: 'SAT'),
  SubjectsEntity(image: "assets/images/English.png", title: 'English')
];

const List<SubjectsEntity> socialSubjects = [
  SubjectsEntity(image: "assets/images/maths.png", title: 'Mathematics'),
  SubjectsEntity(image: "assets/images/SAT.png", title: 'SAT'),
  SubjectsEntity(image: "assets/images/English.png", title: 'English'),
  SubjectsEntity(image: "assets/images/Geography.png", title: 'Geography'),
  SubjectsEntity(image: "assets/images/History.png", title: 'History'),
  SubjectsEntity(
      image: "assets/images/Economics_subject.png", title: 'Economics'),
];
const List<SubjectsEntity> grade9and10Subjects = [
  SubjectsEntity(image: "assets/images/English.png", title: 'English'),
  SubjectsEntity(image: "assets/images/maths.png", title: 'Mathematics'),
  SubjectsEntity(image: "assets/images/SAT.png", title: 'SAT'),
  SubjectsEntity(image: "assets/images/Biology.png", title: 'Biology'),
  SubjectsEntity(image: "assets/images/Chemistry.png", title: 'Chemistry'),
  SubjectsEntity(image: "assets/images/Physics.png", title: 'physics'),
  SubjectsEntity(image: "assets/images/Geography.png", title: 'Geography'),
  SubjectsEntity(image: "assets/images/History.png", title: 'History'),
];
Map<String, String> naturalSubjectImagesMap = {
  "chemistry": "assets/images/Chemistry.png",
  "biology": "assets/images/Biology.png",
  "mathematics": "assets/images/maths.png",
  "physics": "assets/images/Physics.png",
  "sat": "assets/images/SAT.png",
  "english": "assets/images/English.png",
};
Map<String, String> socialSubjectImagesMap = {
  "mathematics": "assets/images/maths.png",
  "sat": "assets/images/SAT.png",
  "english": "assets/images/English.png",
  "geography": "assets/images/Geography.png",
  "history": "assets/images/History.png",
  "economics": "assets/images/Economics_subject.png"
};

List<String> howPrepared = [
  'Very prepared',
  'Somewhat prepared',
  'Not prepared at all'
];

List<String> preferedMethod = [
  'Reading and taking notes',
  'Interactive exercises and practice'
];

List<String> studyTimePerday = [
  'Less than 1 hour',
  '1-2 hours',
  '2-3 hours',
  'More than 3 hours'
];

List<String> motivation = [
  'Achieving academic success',
  'Personal growth and improvement',
];

List<String> streamId = [
  "64c24df185876fbb3f8dd6c7", //natural
  "64c24e0e85876fbb3f8dd6ca",//social
  "65898c5b52f4ffeace9210e6" //grades 9 and 10
];
String contestDescription =
    "Hey there! 🎉 \nReady for an awesome challenge? The SkillBridge's Contest is here! Dive into past national exam questions, earn Coins, and cash out when you hit 100 birr! 🏆💰\nThis is your chance to practice, level up your skills, and have a blast as the big exam approaches. \nKeep practicing, keep earning, and let's see who can collect the most Coins! 💪✨\nDon't miss out on the fun—click the link to register now and join me in the excitement! 🚀";

final termsAndCondition = SettingsContentEntity(
    header: 'Terms and Conditions',
    singleContent: [
      SettingsSingleContentEntity(
        title: "Acceptance of Terms",
        contents: [
          'By accessing and using the SkillBridge mobile application ("App"), you agree to comply with and be bound by these Terms and Conditions ("Terms"). If you do not agree to these Terms, please do not use the App.'
        ],
      ),
      SettingsSingleContentEntity(
        title: "Use of the App",
        contents: [
          "Eligibility: The App is intended for use by high school students. By using the App, you represent that you are a high school student or have permission from a parent or guardian.",
          "Usage Data: We grant you a non-exclusive, non-transferable, revocable license to use the App for personal, non-commercial purposes.",
          "Restrictions: You agree not to: Use the App for any unlawful purpose, Interfere with the operation of the App or attempt to gain unauthorized access to the App or its related systems, and Copy, modify, distribute, sell, or lease any part of the App.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "User Accounts",
        contents: [
          "Registration: To access certain features of the App, you may be required to register for an account. You agree to provide accurate and complete information during the registration process.",
          "Account Security: You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.",
          "Termination: We reserve the right to terminate or suspend your account at any time if we believe you have violated these Terms.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Intellectual Property",
        contents: [
          "Ownership: All content, features, and functionality of the App, including text, graphics, logos, and software, are the property of SkillBridge and are protected by intellectual property laws.",
          "Trademarks: The SkillBridge name and logo are trademarks of SkillBridge. You may not use these trademarks without our prior written permission."
        ],
      ),
      SettingsSingleContentEntity(
        title: "User Content",
        contents: [
          'Responsibility: You are responsible for any content you submit, post, or display on the App ("User Content"). You agree not to post any content that is unlawful, harmful, or infringes on the rights of others.',
          "License: By posting User Content on the App, you grant us a non-exclusive, worldwide, royalty-free license to use, modify, and display your content in connection with the App."
        ],
      ),
      SettingsSingleContentEntity(
        title: "Privacy",
        contents: [
          "Your use of the App is also governed by our Privacy Policy, which explains how we collect, use, and protect your personal information.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Disclaimers and Limitation of Liability",
        contents: [
          'No Warranty: The App is provided "as is" and "as available" without any warranties of any kind, either express or implied. We do not warrant that the App will be uninterrupted or error-free.',
          'Limitation of Liability: In no event shall SkillBridge be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the App.'
        ],
      ),
      SettingsSingleContentEntity(
        title: "Indemnification",
        contents: [
          "You agree to indemnify and hold harmless SkillBridge and its affiliates from any claims, losses, liabilities, damages, and expenses arising out of your use of the App or your violation of these Terms.",
        ],
      ),
      SettingsSingleContentEntity(title: "Changes to the Terms", contents: [
        "We may update these Terms from time to time. We will notify you of any changes by posting the new Terms on this page and updating the effective date. Your continued use of the App after any such changes constitutes your acceptance of the new Terms.",
      ]),
      SettingsSingleContentEntity(title: "Contact Us", contents: [
        "If you have any questions or concerns about these Terms, please contact us at:",
        "Email: contact-skillbridge@a2sv.org"
            "Address: 4th floor, Abrehot Library, Addis Ababa, Ethiopia"
            "By using the SkillBridge App, you agree to these Terms and Conditions."
      ]),
    ],
    date: 'July 30, 2024');

final privacyPolicy = SettingsContentEntity(
    header: 'Privacy Policy',
    singleContent: [
      SettingsSingleContentEntity(
        title: "Introduction",
        contents: [
          "Welcome to SkillBridge, an AI-powered learning platform for high school students. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our mobile application (\"App\").",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Information We Collect",
        contents: [
          "Personal Information: When you register for an account, we may collect personal information such as your name, email address or phone number, and school information.",
          "Usage Data: We collect information about your interactions with the App, such as the content you view, the time spent on different sections, and your performance on learning activities.",
          "Device Information: We may collect information about the device you use to access the App, including the device type, operating system, and unique device identifiers.",
          "Location Data: With your consent, we may collect information about your location to provide location-based services.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "How We Use Your Information",
        contents: [
          "To Provide and Improve Our Services: We use the information we collect to operate, maintain, and improve the App.",
          "Personalization: To personalize your learning experience and provide content and recommendations tailored to your interests and performance.",
          "Communication: To communicate with you about your account, updates, and other relevant information.",
          "Analytics: To analyze usage patterns and improve our App's performance and user experience.",
          "Sharing Your Information",
          "We do not share your personal information with third parties except in the following circumstances:",
          "Service Providers: We may share information with third-party service providers who help us operate and maintain the App.",
          "Legal Requirements: We may disclose information if required to do so by law or in response to valid requests by public authorities.",
          "Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of the transaction.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Data Security",
        contents: [
          "We implement appropriate security measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Your Rights",
        contents: [
          "You have the right to access, update, and delete your personal information. You can do this by logging into your account and making the necessary changes or by contacting us at contact-skillbridge@a2sv.org.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Children's Privacy",
        contents: [
          "Our App is intended for high school students. We do not knowingly collect personal information from children under the age of 13 without parental consent. If we become aware that we have inadvertently received personal information from a child under the age of 13, we will delete such information from our records.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Changes to This Privacy Policy",
        contents: [
          "We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the effective date.",
        ],
      ),
      SettingsSingleContentEntity(
        title: "Contact Us",
        contents: [
          "If you have any questions or concerns about this Privacy Policy, please contact us at:",
          "Email: contact-skillbridge@a2sv.org",
          "Address: Abrehot Library, 4th floor, Addis Ababa, Ethiopia",
          "By using the SkillBridge App, you agree to the terms of this Privacy Policy."
        ],
      ),
    ],
    date: 'July 30, 2024');
