#include "io/io.hpp"

#include "util/bitops.hpp"

void IO::button_pressed(GbButton button) {
    set_button(button, true);
}

void IO::button_released(GbButton button) {
    set_button(button, false);
}

void IO::set_button(GbButton button, bool set) {
    if (button == GbButton::Up) {
        up = set;
    }
    if (button == GbButton::Down) {
        down = set;
    }
    if (button == GbButton::Left) {
        left = set;
    }
    if (button == GbButton::Right) {
        right = set;
    }
    if (button == GbButton::A) {
        A = set;
    }
    if (button == GbButton::B) {
        B = set;
    }
    if (button == GbButton::Select) {
        select = set;
    }
    if (button == GbButton::Start) {
        start = set;
    }
}

void IO::write(u8 set) {

    direction_switch = !check_bit(set, 4);
    button_switch = !check_bit(set, 5);
}

u8 IO::get_input() const {

    u8 buttons = 0b1111;

    if (direction_switch) {
        buttons = set_bit(buttons, 0, !right);
        buttons = set_bit(buttons, 1, !left);
        buttons = set_bit(buttons, 2, !up);
        buttons = set_bit(buttons, 3, !down);
    }

    if (button_switch) {
        buttons = set_bit(buttons, 0, !A);
        buttons = set_bit(buttons, 1, !B);
        buttons = set_bit(buttons, 2, !select);
        buttons = set_bit(buttons, 3, !start);
    }

    buttons = set_bit(buttons, 4, !direction_switch);
    buttons = set_bit(buttons, 5, !button_switch);

    return buttons;
}
