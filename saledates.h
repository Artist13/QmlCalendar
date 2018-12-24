#ifndef SALEDATES_H
#define SALEDATES_H

#include <QObject>
#include <QVector>
#include <QDate>
#include <QException>
#include <QColor>
#include <QQmlEngine>

typedef QVector<QDate> Dates;

class SaleDates : public QObject
{
    Q_OBJECT
public:
    enum DateState{
        ClearDate,
        SaleDate,
        BookedDate
    };
    Q_ENUMS(DateState)
    typedef QVector<DateState> States;

    explicit SaleDates(QObject *parent = nullptr);
    void AddDate(const QDate date);
    void AddDate(const QDate date, DateState state);
    static void declare(){
        qmlRegisterType<SaleDates>("MyStatesEnum", 1, 0, "DateStyle");
    }
    QDate operator[](const int index);
signals:

public slots:
    int getCount() const;
    QDate getByIndex(const int index);
    DateState getState(const int index);
private:
    Dates _dates;
    DateState baseState;
    States _states;
};

#endif // SALEDATES_H
