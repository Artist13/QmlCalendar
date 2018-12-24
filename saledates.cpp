#include "saledates.h"


SaleDates::SaleDates(QObject *parent) : QObject(parent)
{
    baseState = DateState::ClearDate;
}

void SaleDates::AddDate(const QDate date)
{
    _dates.push_back(date);
    _states.push_back(baseState);
}

void SaleDates::AddDate(const QDate date, DateState state)
{
    _dates.push_back(date);
    _states.push_back(state);
}

QDate SaleDates::operator[](const int index)
{
    if (index > _dates.count())
        throw new QException();
    return _dates[index];
}

int SaleDates::getCount() const
{
    return _dates.count();
}

QDate SaleDates::getByIndex(const int index)
{
    return operator[](index);
}

SaleDates::DateState SaleDates::getState(const int index)
{
    if (index > _states.count())
        throw new QException();
    return _states[index];
}
