#pragma once

//~ #ifndef MENU_HANDLER_H
//~ #define MENU_HANDLER_H

namespace ygo {

  class MenuHandler : public irr::IEventReceiver {
  public:
    MenuHandler();

    bool OnEvent(const irr::SEvent &event) override;
    bool OnEvent_EET_GUI_EVENT(const irr::SEvent &event);
    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED(int64_t id);

    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id();
    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id();

    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_FILE_CONFIRMED();
    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED();
    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_FILE_CONFIRMED();
    bool OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED();

    using OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function = bool (MenuHandler::*)();
    std::unordered_map<int64_t, OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function> OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function_unordered_map;

    using OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function = bool (MenuHandler::*)();
    std::unordered_map<int64_t, OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function> OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function_unordered_map;

    irr::s32 prev_operation;
    int prev_sel;
  };

} // namespace ygo

//~ #endif // MENU_HANDLER_H
