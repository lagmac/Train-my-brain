//
//  LocalizationManager.swift
//  My Fish Tank
//
//  Created by Gino Preti on 04/12/20.
//

import Foundation
import SwiftUI

enum LocalizationManager: String
{
    // General
    case app_title
    case level_selection_sub_text
    
    // Summary
    case summary_message_well_done
    case summary_message_great_job
    case summary_message_bad_result
    case summary_message_do_better
    case summary_message_sleep

    // Buttons
    case btn_signin_title
    case btn_signup_title
    case btn_ok_title
    case btn_close_title
    case btn_submit_title
    case btn_next_title
    case btn_goHome_title
    case btn_discard_title
    case btn_continue_title
    case btn_try_again_title
    case btn_update_level
    case btn_confirm_title
    case btn_send_title

    // Alert
    case alert_title
    case alert_signIn_success
    case alert_sigIn_failed
    case alert_new_level
    case alert_new_level_added
    case alert_first_launch_disclaimer
    case alert_level_uptodate
    case alert_question_download_error
    case alert_update_user_name_confirmation
    case alert_update_user_name_success
    case alert_update_user_name_failed
    case alert_reset_score
    case alert_delete_account
    case alert_signout

    // SignUp
    case sign_up_page_title
    case sign_up_page_disclaimer
    case sing_up_email_title
    case sign_up_email_hint
    case sign_up_password_title
    case sign_up_password_hint
    case sign_up_terms_and_conditions_label_title
    case sign_up_privacy_policy_label_title
    case sign_up_terms_and_conditions_accept_label_title
    case sign_up_privacy_policy_accept_label_title
    
    // SignIn
    case sign_in_page_title
    case sing_in_email_title
    case sign_in_email_hint
    case sign_in_password_title
    case sign_in_password_hint
    case sign_in_forgot_password_label_title
    case sign_in_forgot_password_alert_message
    case sign_in_forgot_password_alert_title
    
    // Slide menu
    case slide_menu_footer_title
    case slide_menu_title
    case slide_menu_settings_title
    case slide_menu_chek_new_level
    case slide_menu_leaderboard_title;
    case slide_menu_signout_title
    
    // Settings
    case settings_view_title
    case settings_name_label_title
    case settings_email_label_title
    case settings_uid_label_title
    case settings_name_edit_placeholder
    case settings_notification_toggle_title
    case settings_notification_sound_title
    case settings_reset_score_label_title
    case settings_reset_score_button_title
    case settings_anonymous_username_title
    case settings_delete_account_label_title
    case settings_delete_account_button_title
    case settings_change_password_label_title
    case settings_change_password_button_title
    case settings_change_password_alert_disclaimer
    case settings_change_password_alert_title
    case settings_change_password_current_password_hint
    case settings_change_password_new_password_hint
    case settings_change_password_confirm_password_hint
    
    // Leaderboard
    case leaderboard_view_title
    case leaderboard_view_you_score_label
    case leaderboard_view_you_rank_label
    
    var localizedText: String
    {
        switch self
        {
        case .level_selection_sub_text:
            return NSLocalizedString(LocalizationManager.level_selection_sub_text.rawValue, comment: "")
        case .app_title:
            return NSLocalizedString(LocalizationManager.app_title.rawValue, comment: "")
        case .summary_message_well_done:
            return NSLocalizedString(LocalizationManager.summary_message_well_done.rawValue, comment: "")
        case .summary_message_great_job:
            return NSLocalizedString(LocalizationManager.summary_message_great_job.rawValue, comment: "")
        case .summary_message_bad_result:
            return NSLocalizedString(LocalizationManager.summary_message_bad_result.rawValue, comment: "")
        case .summary_message_do_better:
            return NSLocalizedString(LocalizationManager.summary_message_do_better.rawValue, comment: "")
        case .summary_message_sleep:
            return NSLocalizedString(LocalizationManager.summary_message_sleep.rawValue, comment: "")
        case .btn_signin_title:
            return NSLocalizedString(LocalizationManager.btn_signin_title.rawValue, comment: "")
        case .btn_signup_title:
            return NSLocalizedString(LocalizationManager.btn_signup_title.rawValue, comment: "")
        case .btn_ok_title:
            return NSLocalizedString(LocalizationManager.btn_ok_title.rawValue, comment: "")
        case .btn_close_title:
            return NSLocalizedString(LocalizationManager.btn_close_title.rawValue, comment: "")
        case .btn_submit_title:
            return NSLocalizedString(LocalizationManager.btn_submit_title.rawValue, comment: "")
        case .btn_next_title:
            return NSLocalizedString(LocalizationManager.btn_next_title.rawValue, comment: "")
        case .btn_goHome_title:
            return NSLocalizedString(LocalizationManager.btn_goHome_title.rawValue, comment: "")
        case.btn_discard_title:
            return NSLocalizedString(LocalizationManager.btn_discard_title.rawValue, comment: "")
        case .btn_continue_title:
            return NSLocalizedString(LocalizationManager.btn_continue_title.rawValue, comment: "")
        case .btn_try_again_title:
            return NSLocalizedString(LocalizationManager.btn_try_again_title.rawValue, comment: "")
        case .btn_update_level:
            return NSLocalizedString(LocalizationManager.btn_update_level.rawValue, comment: "")
        case .btn_confirm_title:
            return NSLocalizedString(LocalizationManager.btn_confirm_title.rawValue, comment: "")
        case .btn_send_title:
            return NSLocalizedString(LocalizationManager.btn_send_title.rawValue, comment: "")
        case .alert_title:
            return NSLocalizedString(LocalizationManager.alert_title.rawValue, comment: "")
        case .alert_signIn_success:
            return NSLocalizedString(LocalizationManager.alert_signIn_success.rawValue, comment: "")
        case .alert_sigIn_failed:
            return NSLocalizedString(LocalizationManager.alert_sigIn_failed.rawValue, comment: "")
        case .alert_first_launch_disclaimer:
            return NSLocalizedString(LocalizationManager.alert_first_launch_disclaimer.rawValue, comment: "")
        case .alert_new_level:
            return NSLocalizedString(LocalizationManager.alert_new_level.rawValue, comment: "")
        case .alert_new_level_added:
            return NSLocalizedString(LocalizationManager.alert_new_level_added.rawValue, comment: "")
        case .alert_question_download_error:
            return NSLocalizedString(LocalizationManager.alert_question_download_error.rawValue, comment: "")
        case .alert_update_user_name_confirmation:
            return NSLocalizedString(LocalizationManager.alert_update_user_name_confirmation.rawValue, comment: "")
        case .alert_update_user_name_success:
            return NSLocalizedString(LocalizationManager.alert_update_user_name_success.rawValue, comment: "")
        case .alert_update_user_name_failed:
            return NSLocalizedString(LocalizationManager.alert_update_user_name_failed.rawValue, comment: "")
        case .alert_level_uptodate:
            return NSLocalizedString(LocalizationManager.alert_level_uptodate.rawValue, comment: "")
        case .alert_reset_score:
            return NSLocalizedString(LocalizationManager.alert_reset_score.rawValue, comment: "")            
        case .alert_delete_account:
            return NSLocalizedString(LocalizationManager.alert_delete_account.rawValue, comment: "")
        case .alert_signout:
            return NSLocalizedString(LocalizationManager.alert_signout.rawValue, comment: "")
        case .sign_up_page_title:
            return NSLocalizedString(LocalizationManager.sign_up_page_title.rawValue, comment: "")
        case .sign_up_page_disclaimer:
            return NSLocalizedString(LocalizationManager.sign_up_page_disclaimer.rawValue, comment: "")
        case .sing_up_email_title:
            return NSLocalizedString(LocalizationManager.sing_up_email_title.rawValue, comment: "")
        case .sign_up_email_hint:
            return NSLocalizedString(LocalizationManager.sign_up_email_hint.rawValue, comment: "")
        case .sign_up_password_title:
            return NSLocalizedString(LocalizationManager.sign_up_password_title.rawValue, comment: "")
        case .sign_up_password_hint:
            return NSLocalizedString(LocalizationManager.sign_up_password_hint.rawValue, comment: "")
        case .sign_up_terms_and_conditions_label_title:
            return NSLocalizedString(LocalizationManager.sign_up_terms_and_conditions_label_title.rawValue, comment: "")
        case .sign_up_privacy_policy_label_title:
            return NSLocalizedString(LocalizationManager.sign_up_privacy_policy_label_title.rawValue, comment: "")
        case .sign_up_terms_and_conditions_accept_label_title:
            return NSLocalizedString(LocalizationManager.sign_up_terms_and_conditions_accept_label_title.rawValue, comment: "")
        case .sign_up_privacy_policy_accept_label_title:
            return NSLocalizedString(LocalizationManager.sign_up_privacy_policy_accept_label_title.rawValue, comment: "")
        case .sign_in_page_title:
            return NSLocalizedString(LocalizationManager.sign_in_page_title.rawValue, comment: "")
        case .sing_in_email_title:
            return NSLocalizedString(LocalizationManager.sing_in_email_title.rawValue, comment: "")
        case .sign_in_email_hint:
            return NSLocalizedString(LocalizationManager.sign_in_email_hint.rawValue, comment: "")
        case .sign_in_password_title:
            return NSLocalizedString(LocalizationManager.sign_in_password_title.rawValue, comment: "")
        case .sign_in_password_hint:
            return NSLocalizedString(LocalizationManager.sign_in_password_hint.rawValue, comment: "")
        case .sign_in_forgot_password_label_title:
            return NSLocalizedString(LocalizationManager.sign_in_forgot_password_label_title.rawValue, comment: "")
        case .sign_in_forgot_password_alert_message:
            return NSLocalizedString(LocalizationManager.sign_in_forgot_password_alert_message.rawValue, comment: "")
        case .sign_in_forgot_password_alert_title:
            return NSLocalizedString(LocalizationManager.sign_in_forgot_password_alert_title.rawValue, comment: "")
        case .slide_menu_title:
            return NSLocalizedString(LocalizationManager.slide_menu_title.rawValue, comment: "")
        case .slide_menu_footer_title:
            return NSLocalizedString(LocalizationManager.slide_menu_footer_title.rawValue, comment: "")
        case .slide_menu_settings_title:
            return NSLocalizedString(LocalizationManager.slide_menu_settings_title.rawValue, comment: "")
        case .slide_menu_chek_new_level:
            return NSLocalizedString(LocalizationManager.slide_menu_chek_new_level.rawValue, comment: "")
        case .slide_menu_leaderboard_title:
            return NSLocalizedString(LocalizationManager.slide_menu_leaderboard_title.rawValue, comment: "")
        case .slide_menu_signout_title:
            return NSLocalizedString(LocalizationManager.slide_menu_signout_title.rawValue, comment: "")
        case .settings_view_title:
            return NSLocalizedString(LocalizationManager.settings_view_title.rawValue, comment: "")
        case .settings_name_label_title:
            return NSLocalizedString(LocalizationManager.settings_name_label_title.rawValue, comment: "")
        case .settings_email_label_title:
            return NSLocalizedString(LocalizationManager.settings_email_label_title.rawValue, comment: "")
        case .settings_uid_label_title:
            return NSLocalizedString(LocalizationManager.settings_uid_label_title.rawValue, comment: "")
        case .settings_name_edit_placeholder:
            return NSLocalizedString(LocalizationManager.settings_name_edit_placeholder.rawValue, comment: "")
        case .settings_notification_toggle_title:
            return NSLocalizedString(LocalizationManager.settings_notification_toggle_title.rawValue, comment: "")
        case .settings_notification_sound_title:
            return NSLocalizedString(LocalizationManager.settings_notification_sound_title.rawValue, comment: "")
        case .settings_reset_score_label_title:
            return NSLocalizedString(LocalizationManager.settings_reset_score_label_title.rawValue, comment: "")
        case .settings_reset_score_button_title:
            return NSLocalizedString(LocalizationManager.settings_reset_score_button_title.rawValue, comment: "")
        case .settings_anonymous_username_title:
            return NSLocalizedString(LocalizationManager.settings_anonymous_username_title.rawValue, comment: "")
        case .settings_delete_account_label_title:
            return NSLocalizedString(LocalizationManager.settings_delete_account_label_title.rawValue, comment: "")
        case .settings_delete_account_button_title:
            return NSLocalizedString(LocalizationManager.settings_delete_account_button_title.rawValue, comment: "")
        case .settings_change_password_label_title:
            return NSLocalizedString(LocalizationManager.settings_change_password_label_title.rawValue, comment: "")
        case .settings_change_password_button_title:
            return NSLocalizedString(LocalizationManager.settings_change_password_button_title.rawValue, comment: "")
        case .settings_change_password_alert_disclaimer:
            return NSLocalizedString(LocalizationManager.settings_change_password_alert_disclaimer.rawValue, comment: "")
        case .settings_change_password_alert_title:
            return NSLocalizedString(LocalizationManager.settings_change_password_alert_title.rawValue, comment: "")
        case .settings_change_password_current_password_hint:
            return NSLocalizedString(LocalizationManager.settings_change_password_current_password_hint.rawValue, comment: "")
        case .settings_change_password_new_password_hint:
            return NSLocalizedString(LocalizationManager.settings_change_password_new_password_hint.rawValue, comment: "")
        case .settings_change_password_confirm_password_hint:
            return NSLocalizedString(LocalizationManager.settings_change_password_confirm_password_hint.rawValue, comment: "")
        case .leaderboard_view_title:
            return NSLocalizedString(LocalizationManager.leaderboard_view_title.rawValue, comment: "")
        case .leaderboard_view_you_score_label:
            return NSLocalizedString(LocalizationManager.leaderboard_view_you_score_label.rawValue, comment: "")
        case .leaderboard_view_you_rank_label:
            return NSLocalizedString(LocalizationManager.leaderboard_view_you_rank_label.rawValue, comment: "")
        }
    }
}
