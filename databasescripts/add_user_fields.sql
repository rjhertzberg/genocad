-- adds new fields for the application for account to help clarify legitimacy of account.

alter table users
add position varchar(255);

alter table users
      add why_ask_for_account varchar(2000);
