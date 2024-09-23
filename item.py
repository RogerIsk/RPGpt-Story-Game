from kivy.properties import StringProperty, NumericProperty
from kivy.uix.button import Button
from kivy.uix.popup import Popup
from kivy.uix.label import Label
from kivy.uix.boxlayout import BoxLayout

class Item:
    '''Create an item object for items owned by character'''
    def __init__(self, item_id, name, item_type, bonus_type, bonus_value, image_file):
        self.item_id = item_id
        self.name = name
        self.item_type = item_type
        self.bonus_type = bonus_type
        self.bonus_value = bonus_value
        self.image_file = image_file


class ItemButton(Button):
    '''Create a kivy button for items owned by the character'''
    def __init__(self, item, hero, **kwargs):
        super().__init__(**kwargs)
        self.item = item
        self.hero = hero
        self.background_normal = item.image_file
        self.size_hint = (None, None)
        self.size = (64, 64)
        self.bind(on_press=self.toggle_equip)
        self.bind(on_enter=self.show_popup)
        self.bind(on_leave=self.dismiss_popup)

    def toggle_equip(self, instance):
        # calls method from hero to update stats from equipment
        self.hero.toggle_equip(self.item)

    def show_popup(self, instance):
        content = BoxLayout(orientation='vertical')
        content.add_widget(Label(text=f'Name: {self.item.name}'))
        content.add_widget(Label(text=f'Type: {self.item.item_type}'))
        content.add_widget(Label(text=f'Bonus: {self.item.bonus_value} {self.item.bonus_type}'))
        self.popup = Popup(content=content, size_hint=(None, None), size=(200, 200))
        self.popup.open()

    def dismiss_popup(self, instance):
        if hasattr(self, 'popup'):
            self.popup.dismiss()