from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    is_premium = models.BooleanField(default=False)  # e.g., Premium user for early access to events

    def __str__(self):
        return self.username

print(1)