#include QMK_KEYBOARD_H
#include "version.h"

enum layers {
    BASE,
    MOVE,
    NUM,
    SYM
};

enum custom_keycodes {
    YANK = SAFE_RANGE,
    CUT,
};

enum {
    TD_YANK,
    TD_CUT,
};

tap_dance_action_t tap_dance_actions[] = {
    [TD_YANK] = ACTION_TAP_DANCE_DOUBLE(C(KC_C), YANK),
    [TD_CUT] = ACTION_TAP_DANCE_DOUBLE(C(KC_X), CUT),
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  /*
    [BASE] = LAYOUT(
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______,  _______, _______, _______,  _______,                    _______, _______, _______, _______, _______, _______,
        _______, _______,  _______, _______, _______,            _______, _______,          _______, _______, _______, _______, _______,
                                             _______,  _______,  _______, _______, _______, _______
    ),
  */
  // To assign:
  // open/close brace
  // tilde/grave
  // pipe
  // plus
  // minus
  // symbols
  // F row - fn layer
  // delete
  // tab
  // shift
  // control
  //
  // thumb cluster:
  // enter
  // backspace
  // alt
  // mod switch
  // super
  // the quick brown fox jumps over the lazy dog
  //
    [BASE] = LAYOUT(
         KC_GRV,    KC_1,     KC_2,    KC_3,    KC_4,     KC_5,  _______, _______,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,  KC_EQL,
         KC_TAB,    KC_Q,     KC_W,    KC_E,    KC_R,     KC_T,  _______, _______,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
         KC_ESC,    KC_A,     KC_S,    KC_D,    KC_F,     KC_G,  _______, _______,    KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_QUOT,
        KC_LSFT,    KC_Z,     KC_X,    KC_C,    KC_V,     KC_B,                       KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH, KC_RSFT,
        KC_LCTL, _______,  _______, _______, KC_LALT,            _______, _______,          KC_BSPC, _______, _______, _______, _______,
                                              KC_SPC,    MO(MOVE),  MO(NUM), _______, MO(SYM),  KC_ENT
                                             /*MO(MOVE),  MO(SYM),  MO(NUM), _______, _______, _______*/
    ),
    [MOVE] = LAYOUT(
        _______, _______,      _______, _______, _______,    _______,  _______, _______, _______, _______, _______,  _______, _______, _______,
        _______, _______,  C(KC_RIGHT), _______, _______,    _______,  _______, _______, TD_YANK, _______, _______,  _______, C(KC_V), _______,
        _______, _______,      _______,  TD_CUT, _______,    _______,  _______, _______, KC_LEFT, KC_DOWN,   KC_UP, KC_RIGHT, _______, _______,
        _______, _______,      _______, _______, _______, C(KC_LEFT),                    _______, _______, _______,  _______, _______, _______,
        _______, _______,      _______, _______, _______,              _______, _______,          _______, _______,  _______, _______, _______,
                                                 _______,    _______,  _______, _______, _______, _______
    ),
    [NUM] = LAYOUT(
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______,  KC_NUM, KC_PSLS, KC_PAST, KC_PMNS, KC_PMNS,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, KC_KP_7, KC_KP_8, KC_KP_9, KC_PPLS, KC_PPLS,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, KC_KP_4, KC_KP_5, KC_KP_6, KC_PPLS, KC_PPLS,
        _______, _______,  _______, _______, _______,  _______,                    _______, KC_KP_1, KC_KP_2, KC_KP_3, KC_PENT, KC_PENT,
        _______, _______,  _______, _______, _______,            _______, _______,          KC_KP_0, KC_KP_0, KC_PDOT, KC_PENT, KC_PENT,
                                             _______,  _______,  _______, _______, _______, _______
    ),
    [SYM] = LAYOUT(
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, _______, _______, _______,    _______, _______,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, _______, _______, S(KC_LBRC), S(KC_RBRC), _______,
        _______, S(KC_1),  S(KC_2), S(KC_3), S(KC_4),  S(KC_5),  _______, _______, S(KC_6), S(KC_7), S(KC_8), S(KC_9),    S(KC_0), _______,
        _______, _______,  _______, _______, _______,  _______,                    _______, _______, _______, KC_LBRC,    KC_RBRC, _______,
        _______, _______,  _______, _______, _______,            _______, _______,          _______, _______, _______,    _______, _______,
                                             _______,  _______,  _______, _______, _______, _______
    ),

    /*[SYMB] = LAYOUT(*/
        /*VRSN,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   _______,           _______, KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,*/
        /*_______, KC_EXLM, KC_AT,   KC_LCBR, KC_RCBR, KC_PIPE, _______,           _______, KC_UP,   KC_7,    KC_8,    KC_9,    KC_ASTR, KC_F12,*/
        /*_______, KC_HASH, KC_DLR,  KC_LPRN, KC_RPRN, KC_GRV,  _______,           _______, KC_DOWN, KC_4,    KC_5,    KC_6,    KC_PLUS, _______,*/
        /*_______, KC_PERC, KC_CIRC, KC_LBRC, KC_RBRC, KC_TILD,                             KC_AMPR, KC_1,    KC_2,    KC_3,    KC_BSLS, _______,*/
        /*EE_CLR,  _______, _______, _______, _______,          RM_VALU,           RM_TOGG,          _______, KC_DOT,  KC_0,    KC_EQL,  _______,*/
                                            /*RM_HUED, RM_VALD, RM_HUEU, TOGGLE_LAYER_COLOR,_______, _______*/
    /*),*/
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (record->event.pressed) {
        switch (keycode) {
        case CUT:
            SEND_STRING(SS_LCTL("ax"));
            break;
        case YANK:
            SEND_STRING(SS_LCTL("ac"));
            break;
        }
    }
    return true;
}
