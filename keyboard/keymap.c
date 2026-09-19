#include QMK_KEYBOARD_H
#include "version.h"

enum layers {
    BASE,
    VIM,
    NUM,
    SYM
};

enum custom_keycodes {
    YANK = SAFE_RANGE,
    CUT,
    VIM_APP,
    VIM_INS,
};

enum {
    TD_YANK,
    TD_CUT,
    TD_ESC,
    TD_TAB,
};

tap_dance_action_t tap_dance_actions[] = {
    [TD_YANK] = ACTION_TAP_DANCE_DOUBLE(C(KC_C), YANK),
    [TD_CUT] = ACTION_TAP_DANCE_DOUBLE(C(KC_X), CUT),
    [TD_TAB] = ACTION_TAP_DANCE_DOUBLE(KC_TAB, KC_RIGHT),
    [TD_ESC] = ACTION_TAP_DANCE_LAYER_TOGGLE(KC_ESC, VIM),
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

    [BASE] = LAYOUT(
        KC_GRV,     KC_1,     KC_2,    KC_3,    KC_4,     KC_5,  QK_BOOT, _______,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0, KC_EQL,
        TD(TD_TAB),     KC_Q,     KC_W,    KC_E,    KC_R,     KC_T,  _______, _______,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P, KC_MINS,
        TD(TD_ESC), KC_A,     KC_S,    KC_D,    KC_F,     KC_G,  _______, _______,    KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_QUOT,
        OS_LSFT,    KC_Z,     KC_X,    KC_C,    KC_V,     KC_B,                       KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH, KC_BSLS,
        KC_LCTL, _______,  _______, _______, KC_LALT,            _______, _______,          KC_BSPC, _______, KC_LBRC, KC_RBRC, _______,
                                              KC_SPC,     MO(NUM),  MO(NUM), _______, MO(SYM),  KC_ENT
                                             /*MO(MOVE),  MO(SYM),  MO(NUM), _______, _______, _______*/
    ),
    [VIM] = LAYOUT(
        _______, _______,      _______, _______, _______,    _______,  _______, _______, _______, _______, _______,  _______, _______, _______,
        _______, _______,  C(KC_RIGHT), _______, _______,    _______,  _______, _______, TD_YANK, _______, VIM_INS,  _______, C(KC_V), _______,
        _______, VIM_APP,      _______,  TD_CUT, _______,    _______,  _______, _______, KC_LEFT, KC_DOWN,   KC_UP, KC_RIGHT, _______, _______,
        _______, _______,      _______, _______, _______, C(KC_LEFT),                    _______, _______, _______,  _______, _______, _______,
        _______, _______,      _______, _______, _______,              _______, _______,          _______, _______,  _______, _______, _______,
                                                 _______,    _______,  _______, _______, _______, _______
    ),
    [NUM] = LAYOUT(
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______,  _______, KC_PSLS, KC_PAST, KC_MINUS, KC_MINUS,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, KC_7, KC_8, KC_9, KC_PLUS, KC_PLUS,
        _______, _______,  _______, _______, _______,  _______,  _______, _______, _______, KC_4, KC_5, KC_6, KC_PLUS, KC_PLUS,
        _______, _______,  _______, _______, _______,  _______,                    _______, KC_1, KC_2, KC_3, KC_ENT, KC_ENT,
        _______, _______,  _______, _______, _______,            _______, _______,          KC_0, KC_0, KC_DOT, KC_ENT, KC_ENT,
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
        case VIM_APP:
            layer_off(VIM);
            break;
        case VIM_INS:
            layer_off(VIM);
            break;
        }
    }
    return true;
}

rgb_t layer_colors[] = {
  {0x65, 0x7b, 0x83},
  {0xb5, 0x89, 0x00},
  {0x85, 0x99, 0x00},
};

bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
    uint8_t layer = get_highest_layer(layer_state);

    for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
        for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
            uint8_t index = g_led_config.matrix_co[row][col];
            if (index < led_min || index >= led_max || index == NO_LED) {
              continue;
            }

            keypos_t key = {col, row};
            for (uint8_t i = 0; i <= layer; i++) {
              uint8_t l = layer - i;
              if (keymap_key_to_keycode(l, key) > KC_TRNS) {
                rgb_t *c = layer_colors + l;
                rgb_matrix_set_color(index, c->r, c->g, c->b);
                break;
              }
            }
        }
    }
    return false;
}
